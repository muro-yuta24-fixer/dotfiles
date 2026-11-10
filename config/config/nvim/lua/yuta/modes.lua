-- Change the cursorline color depending on the current mode

local alpha = 0.25

local function to_hex(n) return n and string.format("#%06x", n) end

-- Mix two "#rrggbb" colors
local function blend(fg, bg)
  local function channel(c, i) return tonumber(c:sub(i, i + 1), 16) end
  local out = {}
  for _, i in ipairs({ 2, 4, 6 }) do
    out[#out + 1] = math.floor(channel(fg, i) * alpha + channel(bg, i) * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", unpack(out))
end

local function mode_color(mode)
  local palette = require("solarized-osaka.colors").setup()
  local first = mode:sub(1, 1)

  if mode:sub(1, 2) == "no" then
    local operator = vim.v.operator
    if operator == "y" then
      return palette.yellow
    elseif operator == "d" or operator == "c" then
      return palette.red
    end
    return nil
  elseif first == "i" then
    return palette.blue
  elseif first == "R" then
    return palette.cyan
  elseif first == "v" or first == "V" or first == "\22" or first == "s" or first == "S" or first == "\19" then
    return palette.violet
  end
  return nil
end

local default = {}

local function save_default()
  default.line = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
  default.nr = vim.api.nvim_get_hl(0, { name = "CursorLineNr", link = false })
end

local function apply(mode)
  if not default.line then
    save_default()
  end

  local color = mode_color(mode)
  local bg = to_hex(vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg)
  if not color or not bg then
    vim.api.nvim_set_hl(0, "CursorLine", default.line)
    vim.api.nvim_set_hl(0, "CursorLineNr", default.nr)
    return
  end

  vim.api.nvim_set_hl(0, "CursorLine", { bg = blend(color, bg) })
  vim.api.nvim_set_hl(0, "CursorLineNr", vim.tbl_extend("force", default.nr, { fg = color }))
end

local group = vim.api.nvim_create_augroup("mode_cursorline", { clear = true })

vim.api.nvim_create_autocmd("ModeChanged", {
  group = group,
  callback = function(ev) apply(ev.match:match(":(.*)$") or vim.fn.mode(true)) end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  group = group,
  callback = function()
    save_default()
    apply(vim.fn.mode(true))
  end,
})
