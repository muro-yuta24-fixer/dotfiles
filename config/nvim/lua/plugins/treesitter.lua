return {
  {

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = "all",
      highlight = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      enable = true,
      mode = "topline",
    },
  },
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "AerialToggle",
      "AerialOpen",
      "AerialOpenAll",
      "AerialClose",
      "AerialCloseAll",
      "AerialNext",
      "AerialPrev",
      "AerialGo",
      "AerialInfo",
      "AerialNavToggle",
      "AerialNavOpen",
      "AerialNavClose",
    },
    keys = {
      { "<leader>ar", "<cmd>Telescope aerial<cr>", desc = "Telescope aerial" },
      { "<C-r>", "<cmd>AerialOpen<cr>", desc = "Open aerial window" },
    },
    opts = {
      layout = {
        max_width = { 80, 0.4 },
        min_width = 10,
        placement = "edge",
      },
      attach_mode = "window",
    },
    config = function(_, opts)
      require("aerial").setup(opts)
      require("telescope").load_extension("aerial")
    end,
  },
  {
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
  },
}
