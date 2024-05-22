local icons = require("utils.icons")

return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        styles = {
          comments = "italic",
          types = "bold",
          functions = "bold,italic",
        },
        inverse = {
          visual = true,
        },
      },
    },
    init = function()
      vim.cmd("colorscheme nightfox")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
          },
        },
        lualine_b = {
          {
            "branch",
          },
        },
        lualine_c = {
          {
            "diff",
            colored = true,
            symbols = icons.diff,
          },
          {
            "filename",
            file_status = false,
            newfile_status = false,
            path = 1,
            -- symbols = {},
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            symbols = icons.diagnostics,
            colored = true,
            update_in_insert = true,
            always_visible = true,
          },
          {
            "overseer",
          },
        },
        lualine_y = {
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_z = { "progress", "location" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter",
    opts = {
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
        diagnostics_update_in_insert = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "NvimTree",
            text_align = "center",
            separator = true,
          },
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icons = true,
        show_tab_indicators = false,
        show_duplicate_prefix = false,
        separator_style = "slant",
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" },
        },
        sort_by = "tabs",
      },
    },
  },
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "andersevenrud/nvim_context_vt",
    event = "VeryLazy",
    opts = {},
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "shellRaining/hlchunk.nvim",
    event = "UIEnter",
    opts = {},
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          -- background_colour = "#30363d",
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
    event = "BufRead",
    opts = { "*" },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFocus",
      "NvimTreeFindFile",
      "NvimTreeCollapse",
    },
    keys = {
      { "<C-f>", "<cmd>NvimTreeToggle<cr>", desc = "Open file tree" },
    },
    opts = {
      filters = {
        dotfiles = true,
      },
      disable_netrw = false,
      hijack_netrw = false,

      diagnostics = {
        enable = true,
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "UIEnter",
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens",
    },
    init = function()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar.handlers.search").setup()
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      triggers_blacklist = {
        n = { "d", "y" },
      },
    },
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
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
  },
}
