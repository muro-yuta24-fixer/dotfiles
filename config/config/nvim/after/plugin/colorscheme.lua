vim.o.background = "dark"
require("solarized-osaka").setup({
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
    functions = { bold = true, italic = true },
    variables = { italic = true },
  },
})
vim.cmd.colorscheme("solarized-osaka")
