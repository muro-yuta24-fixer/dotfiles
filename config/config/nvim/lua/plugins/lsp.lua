local ensure_installed = {
  lsp = {
    "lua_ls",

    "dockerls",
    "docker_compose_language_service",

    "csharp_ls",
    -- "omnisharp",

    "ts_ls",
    "volar",
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
      local lspconfig = require("lspconfig")

      local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      cmp_capabilities.offsetEncoding = "utf-16"

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          lspconfig[server_name].setup({
            capabilities = cmp_capabilities,
          })
        end,

        ["ts_ls"] = function()
          local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path() .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

          lspconfig["ts_ls"].setup({
            capabilities = cmp_capabilities,
            root_dir = lspconfig.util.root_pattern("package.json"),
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
        end,

        ["clangd"] = function()
          lspconfig["clangd"].setup({
            capabilities = cmp_capabilities,
          })
        end,

        ["csharp_ls"] = function()
          lspconfig["csharp_ls"].setup({
            handlers = {
              ["textDocument/definition"] = require("csharpls_extended").handler,
              ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
            },
          })
        end,
      })

      lspconfig["denols"].setup({
        capabilities = cmp_capabilities,
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })

      lspconfig["gleam"].setup({
        capabilities = cmp_capabilities,
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
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = ensure_installed.lsp,
      automatic_installation = false,
    },
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
      { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga rename" },
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
        enable = true,
        separator = "  ",
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
    lazy = false,
    opts = {
      ensure_installed = ensure_installed.tools,
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
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {},
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
    "mrcjkb/rustaceanvim",
    dependencies = { "nvim-neotest/neotest" },
    version = "^5",
    lazy = false,
    config = function()
      require("neotest").setup({
        adapters = {
          require("rustaceanvim.neotest"),
        },
      })
    end,
  },
  {
    "Decodetalkers/csharpls-extended-lsp.nvim",
  },
}
