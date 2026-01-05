return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    opts = {},
  },
  {
    "stevearc/aerial.nvim",
    enabled = false,
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
