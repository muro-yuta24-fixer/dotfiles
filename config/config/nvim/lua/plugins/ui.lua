return {
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = { bold = true, italic = true },
        variables = { italic = true },
      },
    },
    config = function(_, opts)
      vim.o.background = "dark"
      require("solarized-osaka").setup(opts)
      vim.cmd("colorscheme solarized-osaka")
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
}
