local icons = require("utils.icons")

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon",
      styles = {
        comments = { italic = true },
        variables = { italic = true, bold = true },
        functions = { italic = true, bold = true },
        keywords = { bold = true },
      },
    },
    init = function() vim.cmd("colorscheme tokyonight") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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
        show_buffer_close_icons = false,
        show_close_icons = false,
        show_tab_indicators = false,
        show_duplicate_prefix = false,
        separator_style = "slant",
        always_show_bufferline = true,
        sort_by = "tabs",
      },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          -- background_colour = "#2e3440",
          timeout = 1000,
        },
      },
    },
    opts = {
      lsp = {
        progress = {
          enabled = true,
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
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    main = "ibl",
    opts = {},
  },
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    opts = { "*" },
  },
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "lewis6991/gitsigns.nvim",
      "kevinhwang91/nvim-hlslens",
    },
    config = function()
      require("scrollbar.handlers.gitsigns").setup()
      require("scrollbar.handlers.search").setup()
      require("scrollbar").setup()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    event = "VeryLazy",
    config = true,
  },
  {
    "b0o/incline.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "folke/tokyonight.nvim",
    },
    opts = {
      hide = {
        cursorline = true,
        focused_win = false,
        only_win = false,
      },
      window = {
        padding = 0,
        margin = { horizontal = 1, vertical = 1 },
        overlap = {
          winbar = true,
        },
      },
      render = function(props)
        local devicons = require("nvim-web-devicons")
        local palette = require("tokyonight.colors").setup()

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, _ = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        local bg = palette.cyan
        local fg = palette.bg_sidebar

        return {
          { "", guifg = bg, guibg = editor_bg },
          { " ", ft_icon, " ", filename, " ", guifg = fg, guibg = bg, gui = modified and "bold,italic" or "bold" },
          { " ", guifg = bg, guibg = editor_bg },
        }
      end,
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<C-f>", "<cmd>NvimTreeToggle<cr>", desc = "Open file tree" },
    },
    opts = {
      filters = {
        dotfiles = true,
      },
      disable_netrw = false,
      hijack_netrw = true,
    },
  },
}
