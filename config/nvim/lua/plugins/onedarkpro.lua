return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      comments = "italic",
      types = "bold",
      functions = "italic,bold",
    },
  },
  config = function(_, opts)
    require("onedarkpro").setup(opts)
    vim.cmd("colorscheme onedark")
  end,
}
