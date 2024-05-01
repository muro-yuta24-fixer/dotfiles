local mason_icons = require("utils.icons").mason

local ensure_installed = {
  "clangd",

  -- "rust_analyzer",

  "lua_ls",

  "dockerls",
  "docker_compose_language_service",

  "html",
  "cssls",
  "tsserver",
  "volar",
  "svelte",
  "astro",
  "tailwindcss",

  "biome",
  "eslint",

  "ruff_lsp",

  "taplo",
}

local builtins = require("conform-selector.builtins")
local js_formatters = builtins.javascript.formatters()

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Installer
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Completion from LSP
      "hrsh7th/cmp-nvim-lsp",
    },
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          icons = mason_icons,
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
      })

      local lspconfig = require("lspconfig")

      local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup_handlers({

        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            capabilities = cmp_capabilities,
          })
        end,

        ["denols"] = function()
          lspconfig["denols"].setup({
            capabilities = cmp_capabilities,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
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
            root_dir = lspconfig.util.root_pattern("package.json"),
            single_file_support = false,
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
            },
          })
        end,

        ["clangd"] = function()
          cmp_capabilities.offsetEncoding = "utf-8"
          lspconfig["clangd"].setup({
            capabilities = cmp_capabilities,
          })
        end,
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Lspsaga" },
    keys = {
      { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lspsaga finder" },
      -- { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga rename" },
      { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover doc" },
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
      { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
      { "gD", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
      { "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Goto next diagnostics" },
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
        enable = false,
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
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
      {
        "<leader>rn",
        ":IncRename " .. vim.fn.expand("<cword>"),
        desc = "Rename symbol",
      },
    },
    config = true,
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
    lazy = false,
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

        "biome",

        -- Linters
        "flake8",
        "yamllint",
      },
      auto_update = true,
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
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
  },
  {
    "folke/neodev.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = { "lua" },
    opts = {},
    config = function(_, opts)
      require("neodev").setup(opts)

      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
    end,
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
}
