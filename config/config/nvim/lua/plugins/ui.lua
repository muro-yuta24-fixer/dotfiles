local icons = require("utils.icons")

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
      integrations = {
        aerial = true,
        fidget = true,
        gitsigns = true,
        hop = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        lsp_saga = true,
        mason = true,
        neogit = true,
        neotest = true,
        noice = true,
        cmp = true,
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
            ok = { "undercurl" },
          },
          inlay_hints = {
            background = true,
          },
        },
        notify = true,
        treesitter_context = true,
        treesitter = true,
        overseer = true,
        telescope = {
          enabled = true,
        },
        lsp_trouble = true,
        which_key = true,
      },
    },
    init = function() vim.cmd("colorscheme catppuccin") end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
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
    opts = function()
      return {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
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
          always_show_bufferline = true,
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
    "b0o/incline.nvim",
    event = "VeryLazy",
    opts = {
      hide = {
        cursorline = false,
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
        local palette = require("catppuccin.palettes").get_palette()

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, _ = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified

        local bg = props.focused and palette.flamingo or palette.blue
        local fg = palette.base

        return {
          { " ", ft_icon, " ", filename, " ", guifg = fg, guibg = bg, gui = modified and "bold,italic" or "bold" },
        }
      end,
    },
  },
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local colors = require("catppuccin.palettes").get_palette()

      local style = {
        colors.blue,
        colors.red,
      }

      return {
        chunk = {
          enable = true,
          style = style,
          proiroty = 15,
          use_treesitter = true,
          error_sign = true,
          duration = 0,
          delay = 0,
        },
        line_num = {
          enable = true,
          style = style,
          priority = 10,
          use_treesitter = true,
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
