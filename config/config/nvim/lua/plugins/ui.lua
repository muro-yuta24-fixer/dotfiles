return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "latte",
      styles = {
        comments = { "italic" },
        conditionals = {},
        functions = { "bold", "italic" },
        keywords = { "bold" },
        strings = {},
        variables = { "italic" },
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      auto_integrations = true,
    },
    init = function() vim.cmd("colorscheme catppuccin-nvim") end,
  },
  {
    "mvllow/modes.nvim",
    tag = "v0.2.1",
    lazy = false,
    opts = function()
      local palette = require("catppuccin.palettes").get_palette()

      return {
        colors = {
          bg = "", -- Optional bg param, defaults to Normal hl group
          copy = palette.yellow,
          delete = palette.red,
          change = palette.red, -- Optional param, defaults to delete
          format = palette.flamingo,
          insert = palette.blue,
          replace = palette.teal,
          select = palette.mauve, -- Optional param, defaults to visual
          visual = palette.mauve,
        },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = function()
      return {
        highlights = require("catppuccin.special.bufferline").get_theme(),
        options = {
          mode = "tabs",
          themable = true,
          numbers = "buffer_id",
          indicator = {
            style = "icon",
          },
          buffer_close_icon = "󰅖",
          modified_icon = "●",
          close_icon = "",
          left_trunc_marker = "",
          right_trunc_marker = "",
          diagnostics = "nvim_lsp",
          offsets = {},
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = false,
          show_close_icons = false,
          show_tab_indicators = false,
          show_duplicate_prefix = false,
          separator_style = "slant",
          always_show_bufferline = false,
          sort_by = "tabs",
        },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
}
