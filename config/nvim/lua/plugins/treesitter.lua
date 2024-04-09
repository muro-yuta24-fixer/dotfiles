return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = "all",
    highlight = { enable = true },
  },
}
