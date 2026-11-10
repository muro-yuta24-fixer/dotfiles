local M = {}

local function bg_of(group) return vim.api.nvim_get_hl(0, { name = group, link = false }).bg end

---@type table<string, boolean>
local icon_hl_cache = {}

local function set_highlights()
  icon_hl_cache = {}
  local ok, colors = pcall(require, "solarized-osaka.colors")
  if not ok then
    return
  end
  local p = colors.setup()
  local bg, sel_bg = bg_of("TabLine"), bg_of("TabLineSel")
  vim.api.nvim_set_hl(0, "TabLineAccent", { fg = p.violet, bg = sel_bg })
  vim.api.nvim_set_hl(0, "TabLineModified", { fg = p.orange, bg = bg })
  vim.api.nvim_set_hl(0, "TabLineSelModified", { fg = p.orange, bg = sel_bg })
end

--- Devicon color on the selected tab's background
---@param icon_hl string
local function selected_icon_hl(icon_hl)
  local name = "TabLineSel" .. icon_hl
  if not icon_hl_cache[name] then
    local fg = vim.api.nvim_get_hl(0, { name = icon_hl, link = false }).fg
    vim.api.nvim_set_hl(0, name, { fg = fg, bg = bg_of("TabLineSel") })
    icon_hl_cache[name] = true
  end
  return name
end

---@param s string
local function escape(s) return (s:gsub("%%", "%%%%")) end

---@param tabpage integer
---@param selected boolean
local function label(tabpage, selected)
  local nr = vim.api.nvim_tabpage_get_number(tabpage)
  local win = vim.api.nvim_tabpage_get_win(tabpage)
  local buf = vim.api.nvim_win_get_buf(win)
  local name = vim.api.nvim_buf_get_name(buf)
  local filename = name == "" and "[No Name]" or vim.fn.fnamemodify(name, ":t")

  local base_hl = selected and "%#TabLineSel#" or "%#TabLine#"
  local parts = {
    selected and "%#TabLineAccent#▎" or "%#TabLine# ",
    base_hl .. nr .. " ",
  }

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local icon, icon_hl = devicons.get_icon(filename, nil, { default = true })
    if icon then
      -- Colored icon only on the selected tab; inactive tabs stay muted
      table.insert(parts, (selected and ("%#" .. selected_icon_hl(icon_hl) .. "#") or base_hl) .. icon .. " ")
    end
  end

  table.insert(parts, base_hl .. escape(filename))
  if vim.bo[buf].modified then
    table.insert(parts, (selected and "%#TabLineSelModified#" or "%#TabLineModified#") .. " ●")
  end
  table.insert(parts, base_hl .. " ")

  -- Click to switch tab
  return ("%%%dT%s%%T"):format(nr, table.concat(parts))
end

function M.render()
  local current = vim.api.nvim_get_current_tabpage()
  local labels = {}
  for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    table.insert(labels, label(tabpage, tabpage == current))
  end
  return table.concat(labels) .. "%#TabLineFill#"
end

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("yuta_tabline", { clear = true }),
  callback = set_highlights,
})
set_highlights()

_G.YutaTabline = M.render
vim.o.tabline = "%!v:lua.YutaTabline()"
vim.o.showtabline = 1

return M
