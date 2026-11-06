-- Statusline: [git branch] [file icon + path] ... [LSP progress / clients]
-- Replaces fidget.nvim for LSP progress.

local M = {}

local sep = " │ "
local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_index = 1

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
    return ("%%#StatusLineLspProgress#%s %s"):format(spinner[spinner_index], items[1])
      .. (#items > 1 and (" +" .. (#items - 1)) or "")
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
  for _, part in ipairs({ git_branch(), file_path() }) do
    if part ~= "" then
      table.insert(left, part)
    end
  end
  return " "
    .. table.concat(left, "%#StatusLineSep#" .. sep)
    .. "%<%="
    .. lsp()
    .. " "
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
