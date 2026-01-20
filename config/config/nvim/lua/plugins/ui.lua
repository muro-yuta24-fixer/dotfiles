return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
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
    init = function() vim.cmd("colorscheme catppuccin") end,
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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          timeout = 1000,
        },
      },
    },
    opts = {
      lsp = {
        progress = {
          enabled = false,
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = { "*" },
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
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
  {
    "RRethy/vim-illuminate",
    event = "BufRead",
    opts = {
      providers = {
        "lsp",
        "treesitter",
      },
    },
    config = function(_, opts) require("illuminate").configure(opts) end,
  },
}
