return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    enable = true,
    mode = "topline",
  },
}
