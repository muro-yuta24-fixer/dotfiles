return {
  "yioneko/nvim-yati",
  dependencies = "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  version = "*",
  main = "nvim-treesitter.configs",
  opts = {
    yati = {
      enable = true,
      -- Whether to enable lazy mode (recommend to enable this if bad indent happens frequently)
      default_lazy = true,

      default_fallback = "asis",
    },
    indent = {
      enable = false, -- disable builtin indent module
    },
  },
}
