local M = {}

local sep = " │ "
local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_index = 1

local crumb_sep = " > "
-- Breadcrumbs may use at most this fraction of the screen width
local crumb_max_ratio = 0.4

---@type table<string, { client: string, title?: string, message?: string, percentage?: integer }>
local progress = {}
local timer = assert(vim.uv.new_timer())

local function set_highlights()
  local ok, palettes = pcall(require, "catppuccin.palettes")
  if not ok then
    return
  end
  local p = palettes.get_palette()
  -- Only fg is set; bg is inherited from StatusLine ('statusline' highlight stacking).
  vim.api.nvim_set_hl(0, "StatusLineGit", { fg = p.mauve, bold = true })
  vim.api.nvim_set_hl(0, "StatusLinePath", { fg = p.text })
  vim.api.nvim_set_hl(0, "StatusLineModified", { fg = p.peach, bold = true })
  vim.api.nvim_set_hl(0, "StatusLineSep", { fg = p.surface2 })
  vim.api.nvim_set_hl(0, "StatusLineLsp", { fg = p.subtext0 })
  vim.api.nvim_set_hl(0, "StatusLineLspProgress", { fg = p.blue })
  vim.api.nvim_set_hl(0, "StatusLineCrumbSep", { fg = p.overlay1 })
  vim.api.nvim_set_hl(0, "StatusLineCrumb", { fg = p.subtext1 })
end

---@param s string
local function escape(s) return (s:gsub("%%", "%%%%")) end

local function git_branch()
  local head = vim.b.gitsigns_head
  if not head or head == "" then
    return ""
  end
  return "%#StatusLineGit# " .. escape(head)
end

local function file_path()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return "%#StatusLinePath#[No Name]"
  end

  local path = vim.fn.fnamemodify(name, ":~:.")
  local icon, icon_hl = "", nil
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    icon, icon_hl = devicons.get_icon(vim.fn.fnamemodify(name, ":t"), nil, { default = true })
  end

  local parts = {}
  if icon and icon ~= "" then
    table.insert(parts, ("%%#%s#%s "):format(icon_hl or "StatusLinePath", icon))
  end
  table.insert(parts, "%#StatusLinePath#" .. escape(path))
  if vim.bo.modified then
    table.insert(parts, "%#StatusLineModified# ●")
  elseif vim.bo.readonly or not vim.bo.modifiable then
    table.insert(parts, "%#StatusLineModified# ")
  end
  return table.concat(parts)
end

-- LSP symbol breadcrumbs (textDocument/documentSymbol)

-- SymbolKind name -> { icon, highlight group }
local symbol_kinds = {
  File = { "󰈔", "@string.special.path" },
  Module = { "󰅩", "@module" },
  Namespace = { "󰅩", "@module" },
  Package = { "󰏖", "@module" },
  Class = { "󱡠", "@type" },
  Method = { "󰊕", "@function.method" },
  Property = { "󰖷", "@property" },
  Field = { "󰜢", "@variable.member" },
  Constructor = { "󰒓", "@constructor" },
  Enum = { "󰦨", "@type" },
  Interface = { "󱡠", "@type" },
  Function = { "󰊕", "@function" },
  Variable = { "󰆦", "@variable" },
  Constant = { "󰏿", "@constant" },
  String = { "󰉿", "@string" },
  Number = { "󰎠", "@number" },
  Boolean = { "󰨙", "@boolean" },
  Array = { "󰅪", "@variable" },
  Object = { "󰅩", "@type" },
  Key = { "󰌋", "@property" },
  Null = { "󰟢", "@constant.builtin" },
  EnumMember = { "󰦨", "@constant" },
  Struct = { "󱡠", "@type" },
  Event = { "󱐋", "@type" },
  Operator = { "󰪚", "@operator" },
  TypeParameter = { "󰬛", "@type" },
}

---@type table<integer, lsp.DocumentSymbol[]|lsp.SymbolInformation[]>
local symbols_by_buf = {}

---@param bufnr integer
local function request_symbols(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  local client = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/documentSymbol" })[1]
  if not client then
    symbols_by_buf[bufnr] = nil
    return
  end
  local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }
  client:request("textDocument/documentSymbol", params, function(err, result)
    if err or not vim.api.nvim_buf_is_valid(bufnr) then
      return
    end
    symbols_by_buf[bufnr] = result or {}
    vim.cmd.redrawstatus()
  end, bufnr)
end

--- (line, character) <= (line, character)
local function pos_le(a_line, a_char, b_line, b_char) return a_line < b_line or (a_line == b_line and a_char <= b_char) end

---@param range lsp.Range
local function range_contains(range, line, char) return pos_le(range.start.line, range.start.character, line, char) and pos_le(line, char, range["end"].line, range["end"].character) end

--- Symbols enclosing the cursor, outermost first.
---@param symbols lsp.DocumentSymbol[]|lsp.SymbolInformation[]
---@return { name: string, kind: integer }[]
local function enclosing_symbols(symbols, line, char)
  local path = {}
  if symbols[1] and symbols[1].location then
    -- SymbolInformation[] (flat list)
    for _, s in ipairs(symbols) do
      if range_contains(s.location.range, line, char) then
        table.insert(path, s)
      end
    end
    table.sort(path, function(a, b)
      local ra, rb = a.location.range, b.location.range
      if ra.start.line ~= rb.start.line or ra.start.character ~= rb.start.character then
        return pos_le(ra.start.line, ra.start.character, rb.start.line, rb.start.character)
      end
      return pos_le(rb["end"].line, rb["end"].character, ra["end"].line, ra["end"].character)
    end)
    return path
  end

  -- DocumentSymbol[] (hierarchical)
  local level = symbols
  while level do
    local found
    for _, s in ipairs(level) do
      if range_contains(s.range, line, char) then
        found = s
        break
      end
    end
    if not found then
      break
    end
    table.insert(path, found)
    level = found.children
  end
  return path
end

local function breadcrumbs()
  local symbols = symbols_by_buf[vim.api.nvim_get_current_buf()]
  if not symbols or #symbols == 0 then
    return ""
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1] - 1
  local text = vim.api.nvim_get_current_line()
  local char = vim.str_utfindex(text, "utf-16", math.min(cursor[2], #text), false)

  local path = enclosing_symbols(symbols, line, char)
  if #path == 0 then
    return ""
  end

  local items = {}
  for _, s in ipairs(path) do
    local kind = symbol_kinds[vim.lsp.protocol.SymbolKind[s.kind] or ""] or { "", "StatusLineCrumb" }
    local name = s.name:gsub("%s+", " ")
    table.insert(items, { icon = kind[1], hl = kind[2], name = name })
  end

  -- Drop outer items when too long
  local budget = math.floor(vim.o.columns * crumb_max_ratio)
  local truncated = false
  local function width()
    local w = 0
    for _, it in ipairs(items) do
      w = w + vim.api.nvim_strwidth(it.icon .. " " .. it.name .. crumb_sep)
    end
    return w
  end
  while #items > 1 and width() > budget do
    table.remove(items, 1)
    truncated = true
  end

  local parts = {}
  if truncated then
    table.insert(parts, "%#StatusLineCrumb#…")
  end
  for _, it in ipairs(items) do
    table.insert(parts, ("%%#%s#%s %s"):format(it.hl, it.icon, escape(it.name)))
  end
  local separator = "%#StatusLineCrumbSep#" .. crumb_sep
  return separator .. table.concat(parts, separator)
end

local function lsp()
  -- Show in-progress work first (fidget replacement)
  local items = {}
  for _, item in pairs(progress) do
    local text = item.client .. ": " .. (item.title or "")
    if item.message and item.message ~= "" then
      text = text .. " " .. item.message
    end
    if item.percentage then
      text = text .. (" (%d%%)"):format(item.percentage)
    end
    table.insert(items, escape(text))
  end
  if #items > 0 then
    table.sort(items)
    return ("%%#StatusLineLspProgress#%s %s"):format(spinner[spinner_index], items[1]) .. (#items > 1 and (" +" .. (#items - 1)) or "")
  end

  -- Otherwise list attached clients
  local names = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(names, client.name)
  end
  if #names == 0 then
    return ""
  end
  return "%#StatusLineLsp# " .. escape(table.concat(names, ", "))
end

function M.render()
  local left = {}
  for _, part in ipairs({ git_branch(), file_path() .. breadcrumbs() }) do
    if part ~= "" then
      table.insert(left, part)
    end
  end
  return " " .. table.concat(left, "%#StatusLineSep#" .. sep) .. "%<%=" .. lsp() .. " "
end

local function start_spinner()
  if timer:is_active() then
    return
  end
  timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      if next(progress) == nil then
        timer:stop()
      end
      spinner_index = spinner_index % #spinner + 1
      vim.cmd.redrawstatus()
    end)
  )
end

local group = vim.api.nvim_create_augroup("yuta_statusline", { clear = true })

vim.api.nvim_create_autocmd("LspProgress", {
  group = group,
  callback = function(ev)
    local params = ev.data.params
    local value = params.value
    if type(value) ~= "table" then
      return
    end
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local key = ev.data.client_id .. ":" .. tostring(params.token)

    if value.kind == "end" then
      progress[key] = nil
    else
      local prev = progress[key] or {}
      progress[key] = {
        client = client and client.name or "lsp",
        title = value.title or prev.title,
        message = value.message,
        percentage = value.percentage,
      }
      start_spinner()
    end
    vim.cmd.redrawstatus()
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = group,
  callback = function(ev)
    for key in pairs(progress) do
      if key:match("^" .. ev.data.client_id .. ":") then
        progress[key] = nil
      end
    end
    vim.schedule(function() vim.cmd.redrawstatus() end)
  end,
})

vim.api.nvim_create_autocmd({ "LspAttach", "BufEnter", "BufWritePost" }, {
  group = group,
  callback = function() vim.cmd.redrawstatus() end,
})

-- Breadcrumbs: fetch symbols on attach / save, redraw on cursor move
vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost" }, {
  group = group,
  callback = function(ev) request_symbols(ev.buf) end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = group,
  callback = function(ev)
    -- Re-request from a remaining client (or clear) after the detach completes
    vim.schedule(function() request_symbols(ev.buf) end)
  end,
})

vim.api.nvim_create_autocmd("BufWipeout", {
  group = group,
  callback = function(ev) symbols_by_buf[ev.buf] = nil end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
  group = group,
  callback = function()
    if symbols_by_buf[vim.api.nvim_get_current_buf()] then
      vim.cmd.redrawstatus()
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "GitSignsUpdate",
  callback = function() vim.cmd.redrawstatus() end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = set_highlights,
})

set_highlights()

_G.YutaStatusline = M.render
vim.o.statusline = "%!v:lua.YutaStatusline()"

return M
