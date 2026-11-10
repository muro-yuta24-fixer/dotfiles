local later = require("utils.defer").later

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

-- which-key
vim.o.timeout = true
vim.o.timeoutlen = 300

later(function()
  require("todo-comments").setup({})
  require("which-key").setup({})
end)
