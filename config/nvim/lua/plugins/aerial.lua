return {
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
    require("telescope").load_extension("aerial")
  end,
}
