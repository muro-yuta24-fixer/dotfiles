local ensure_installed = {
  lsp = {
    "lua_ls",

    "dockerls",
    "docker_compose_language_service",

    -- "csharp_ls",
    -- "omnisharp",

    "ts_ls",
    "vue_ls",

    "pyright",
  },
  tools = {
    -- Formatters
    "stylua",

    "yamlfmt",

    "biome",

    -- Linters
  },
}

local builtins = require("conform-selector.builtins")
local js_formatters = builtins.javascript.formatters()

local browser = require("utils.exec").browser

local configure_lsp = require("utils.lsp-config-wrapper").configure_lsp

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    -- event = "LspAttach",
    lazy = false,
    opts = {
      ensure_installed = ensure_installed.lsp,
      automatic_enable = {
        exclude = {
          "denols",
          "ts_ls",
          "csharp_ls",
          "pyright",
        },
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local vue_typescript_plugin = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin")

      configure_lsp("ts_ls", {
        root_markers = { "package.json" },
        single_file_support = false,
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_typescript_plugin,
              languages = { "vue" },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })

      configure_lsp("csharp_ls", {
        handlers = {
          ["textDocument/definition"] = require("csharpls_extended").handler,
          ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
        },
      })

      -- configure_lsp("denols", {
      --   root_markers = { "deno.json", "deno.jsonc" },
      -- })

      configure_lsp("pyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict",
              -- typeCheckingMode = "standard",
            },
          },
        },
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      auto_update = true,
      run_on_start = true,
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    cmd = { "Lspsaga" },
    keys = {
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lspsaga finder" },
      { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga rename" },
      { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover doc" },
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
      { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
      { "gD", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
      { "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Goto next diagnostics" },
      { "<leader>e", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Show line diagnostics" },
    },
    opts = function()
      return {
        ui = {
          kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
        },
        lightbulb = {
          enable = false,
        },
        finder = {
          layout = "float",
          silent = false,
          keys = {
            toggle_or_open = { "o", "<space>" },
            vsplit = { "<C-v>" },
            tabnew = { "<C-t>" },
            quit = { "q", "<ESC>" },
          },
        },
        rename = {
          in_select = true,
          auto_save = true,
          keys = {
            exec = { "<CR>" },
            quit = { "<ESC>" },
          },
        },
        hover_doc = {
          open_cmd = browser(),
        },
        code_action = {
          num_shortcut = true,
          show_server_name = true,
          extend_gitsigns = false,
          keys = {
            quit = { "q", "<ESC>" },
            exec = { "<CR>" },
          },
        },
        symbol_in_winbar = {
          separator = "  ",
          enable = true,
          show_file = true,
        },
        diagnostics = {
          show_code_action = true,
          keys = {
            quit = { "q", "<ESC>" },
          },
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    keys = {
      { "<leader>tr", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Show workspace diagnostics" },
    },
    opts = {
      position = "bottom",
      height = 20,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = {},
      },
      use_diagnostics_signs = true,
    },
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },

        cs = {
          inherit = false,
          command = "dotnet",
          args = { "format", "--include", vim.fn.expand("%") },
        },

        lua = { "stylua" },

        html = js_formatters,
        css = js_formatters,
        scss = js_formatters,
        javascript = js_formatters,
        javascriptreact = js_formatters,
        typescript = js_formatters,
        typescriptreact = js_formatters,
        svelte = js_formatters,
        astro = js_formatters,
        vue = js_formatters,

        json = { "jq" },
        jsonc = { "jq" },
        toml = { "taplo" },
        -- yaml = { "yamlfmt" },

        fish = { "fish_indent" },
        sh = { "beautysh" },
      },
      format_on_save = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    "folke/lazydev.nvim",
    ft = { "lua" },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true },
      {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0,
          })
        end,
      },
    },
    opts = {
      library = {
        "lazy.nvim",
      },
    },
  },
  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
  },
}
