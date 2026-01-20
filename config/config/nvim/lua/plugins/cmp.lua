return {
  {
    "Saghen/blink.cmp",
    lazy = false,
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
        per_filetype = {
          markdown = { "path" },
          lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
          gitcommit = { "gitmoji", "path" },
          sagarename = {},
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          gitmoji = {
            name = "gitmoji",
            module = "gitmoji.blink",
            opts = {
              filetypes = { "gitcommit" },
              completion = {
                append_space = true,
                complete_as = "emoji",
              },
            },
          },
        },
      },
      keymap = {
        preset = "super-tab",
      },
      appearance = {
        nerd_font_variant = "normal",
      },
      completion = {
        menu = {
          border = "rounded",
          -- draw = {
          --   components = {
          --     kind_icon = {
          --       text = function(ctx)
          --         local icon = ctx.kind_icon
          --         if vim.tbl_contains({ "Path" }, ctx.source_name) then
          --           local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
          --           if dev_icon then
          --             icon = dev_icon
          --           end
          --         else
          --           icon = require("lspkind").symbolic(ctx.kind, {
          --             mode = "symbol",
          --           })
          --         end
          --
          --         return icon .. ctx.icon_gap
          --       end,
          --
          --       -- Optionally, use the highlight groups from nvim-web-devicons
          --       -- You can also add the same function for `kind.highlight` if you want to
          --       -- keep the highlight groups in sync with the icons.
          --       highlight = function(ctx)
          --         local hl = ctx.kind_hl
          --         if vim.tbl_contains({ "Path" }, ctx.source_name) then
          --           local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
          --           if dev_icon then
          --             hl = dev_hl
          --           end
          --         end
          --         return hl
          --       end,
          --     },
          --   },
          -- },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = {
            border = "rounded",
          },
        },
        trigger = {
          show_on_insert_on_trigger_character = true,
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        ghost_text = {
          enabled = true,
          show_with_menu = true,
        },
      },
      signature = {
        enabled = true,
        window = {
          border = "rounded",
        },
      },
      fuzzy = {
        implementation = "rust",
      },
    },
  },
  {
    "onsails/lspkind.nvim",
  },
  {
    "Dynge/gitmoji.nvim",
  },
}
