return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { { "yioneko/nvim-yati", version = "*" } },
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = "all",
      highlight = { enable = true },
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
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>ar", "<cmd>Telescope aerial<cr>", desc = "Telescope aerial" },
    },
    opts = {},
    config = function(_, opts)
      require("aerial").setup(opts)

      local telescope = require("telescope")
      telescope.load_extension("aerial")
    end,
  },
}
