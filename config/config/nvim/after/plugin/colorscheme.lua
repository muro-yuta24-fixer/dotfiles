require("catppuccin").setup({
  flavour = "latte",
  styles = {
    comments = { "italic" },
    conditionals = {},
    functions = { "bold", "italic" },
    keywords = { "bold" },
    strings = {},
    variables = { "italic" },
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
    lsp_styles = {
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
        ok = { "italic" },
      },
      underlines = {
        errors = { "undercurl" },
        hints = { "undercurl" },
        warnings = { "undercurl" },
        information = { "undercurl" },
        ok = { "undercurl" },
      },
      inlay_hints = {
        background = true,
      },
    },
  },
  auto_integrations = true,
})
vim.cmd.colorscheme("catppuccin-nvim")
