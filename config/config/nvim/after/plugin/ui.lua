-- which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function() require("which-key").setup({}) end,
})

-- incline: floating filename per window
local diagnostic_icons = {
  error = " ", -- nf-oct-bug
  warn = " ", -- nf-oct-alert
  info = " ", -- nf-oct-info
  hint = " ", -- nf-oct-light_bulb
}

local function get_diagnostic_label(props)
  local label = {}

  for severity, icon in pairs(diagnostic_icons) do
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

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    require("incline").setup({
      hide = {
        cursorline = true,
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
        local palette = require("solarized-osaka.colors").setup()

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        local bg = props.focused and palette.magenta or palette.base03
        local fg = props.focused and palette.base04 or palette.base0

        local diagnostic_bg = palette.base03

        return {
          { get_diagnostic_label(props), guibg = diagnostic_bg },
          ft_icon and { " ", ft_icon, " ", guibg = bg, guifg = fg } or " ",
          { filename, " ", guifg = fg, guibg = bg, gui = modified and "bold,italic" or "bold" },
        }
      end,
    })
  end,
})
