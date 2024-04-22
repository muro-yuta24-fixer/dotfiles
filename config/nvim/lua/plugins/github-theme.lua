return {
  "projekt0n/github-nvim-theme",
  lazy = false,
  priority = 1000,
  opts = {
    options = {
      styles = {
        comments = "italic",
        functions = "italic,bold",
        types = "bold",
      },
    },
  },
  config = function(_, opts)
    require("github-theme").setup(opts)
    vim.cmd("colorscheme github_light")
  end,
}
