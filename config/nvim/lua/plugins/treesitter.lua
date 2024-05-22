return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = "all",
      highlight = { enable = true },
      endwise = { enable = true },
    },
  },
  {
    "RRethy/nvim-treesitter-endwise",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "InsertEnter",
    main = "nvim-treesitter.configs",
    opts = {
      endwise = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = false,
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
      { ";s", "<cmd>Telescope aerial<cr>", desc = "Telescope aerial" },
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
    init = function()
      local telescope = require("telescope")
      telescope.load_extension("software-licenses")
    end,
  },
  {
    "yioneko/nvim-yati",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "InsertEnter",
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
