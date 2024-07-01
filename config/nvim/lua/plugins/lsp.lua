local mason_icons = require("utils.icons").mason

local ensure_installed = {
  lsp = {
    "lua_ls",

    "dockerls",
    "docker_compose_language_service",

    "html",
    "cssls",
    "tsserver",
    "volar",

    "omnisharp",

    "eslint",
  },
  tools = {
    "stylua",
    "jq",
    "commitlint",
    "yamlfmt",
  },
}

local builtins = require("conform-selector.builtins")
local js_formatters = builtins.javascript.formatters()

return {
  {
    "neovim/nvim-lspconfig",
    -- evnet = "LspAttach",
    lazy = false,
    dependencies = {
      -- LSP Installer
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Completion from LSP
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            capabilities = cmp_capabilities,
          })
        end,

        ["volar"] = function()
          lspconfig["volar"].setup({
            capabilities = cmp_capabilities,
            filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
          })
        end,

        ["tsserver"] = function()
          local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path() .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

          lspconfig["tsserver"].setup({
            init_options = {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_typescript_plugin,
                  languages = { "javascript", "typescript", "vue" },
                },
              },
            },
            capabilities = cmp_capabilities,
          })
        end,

        ["clangd"] = function()
          cmp_capabilities.offsetEncoding = "utf-16"
          lspconfig["clangd"].setup({
            capabilities = cmp_capabilities,
          })
        end,

        -- ["lua_ls"] = function()
        --   -- lazydev.nvim
        -- end,

        ["omnisharp"] = function()
          lspconfig["omnisharp"].setup({
            settings = {
              FormattingOptions = {
                EnableEditorConfigSupport = true,
                OrganizeImports = true,
              },
              MsBuild = {
                LoadProjectsOnDemand = true,
              },
              RoslynExtensionsOptions = {
                EnableAnalyzerSupport = true,
                EnableImportCompletion = true,
                AnalyzeOpenDocumentsOnly = false,
              },
            },
          })
        end,
      })

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = mason_icons,
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = ensure_installed.lsp,
      automatic_installation = false,
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    requires = { "nvim-lua/plenary.nvim" },
    event = "LspAttach",
    opts = {},
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lspsaga finder" },
      { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga rename" },
      { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover doc" },
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
      { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
      { "gD", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Goto next diagnostics" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Goto previous diagnostics" },
      { "<leader>e", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Show line diagnostics" },
    },
    opts = {
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
        open_cmd = "!wslview",
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
        enable = true,
        separator = "  ",
        show_file = true,
      },
      diagnostics = {
        show_code_action = true,
        keys = {
          quit = { "q", "<ESC>" },
        },
      },
    },
  },
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",
        "clang-format",
        "rustywind",

        "black",
        "isort",

        "jq",
        "yamlfmt",

        -- "biome",

        -- Linters
        "flake8",
        "yamllint",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    "stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },

        -- cs = { "csharpier" },

        lua = { "stylua" },

        python = { "black", "isort" },

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
        yaml = { "yamlfmt" },

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
    "folke/lazydev.nvim",
    ft = { "lua" },
    dependencies = {
      { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
      { -- optional completion source for require statements and module annotations
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
          opts.sources = opts.sources or {}
          table.insert(opts.sources, {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
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
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {},
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    enabled = false,
    opts = {},
  },
}
