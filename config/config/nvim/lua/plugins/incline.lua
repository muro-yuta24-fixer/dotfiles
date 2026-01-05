local function get_diagnostic_label(props)
  local icons = require("utils.icons").diagnostics
  local label = {}

  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
    if n > 0 then
      table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
    end
  end
  if #label > 0 then
    table.insert(label, { " " })
  end
  return label
end

return {
  "b0o/incline.nvim",
  event = "VeryLazy",

  opts = {
    hide = {
      cursorline = false,
      focused_win = false,
      only_win = false,
    },
    window = {
      padding = 0,
      margin = { horizontal = 1, vertical = 1 },
      overlap = {
        winbar = true,
      },
    },

    render = function(props)
      local helpers = require("incline.helpers")
      local devicons = require("nvim-web-devicons")
      local palette = require("catppuccin.palettes").get_palette()

      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
      if filename == "" then
        filename = "[No Name]"
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)
      local modified = vim.bo[props.buf].modified

      local bg = props.focused and ft_color or palette.base
      local fg = props.focused and helpers.contrast_color(bg) or palette.text

      local diagnostic_bg = palette.base

      return {
        { get_diagnostic_label(props), guibg = diagnostic_bg },
        ft_icon and { " ", ft_icon, " ", guibg = bg, guifg = fg } or " ",
        { filename, " ", guifg = fg, guibg = bg, gui = modified and "bold,italic" or "bold" },
      }
    end,
  },
}
