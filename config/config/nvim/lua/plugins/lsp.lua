local ensure_installed = {
  lsp = {
    "lua_ls",

    "dockerls",
    "docker_compose_language_service",

    "csharp_ls",
    -- "omnisharp",

    "ts_ls",
    "volar",

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

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
      cmp_capabilities.offsetEncoding = { "utf-8" }

      vim.lsp.config("*", {
        capabilities = cmp_capabilities,
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name) -- default handler (optional)
          vim.lsp.enable(server_name)
        end,

        ["ts_ls"] = function()
          local vue_typescript_plugin = require("mason-registry").get_package("vue-language-server"):get_install_path() .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

          vim.lsp.config("ts_ls", {
            -- root_dir = lspconfig.util.root_pattern("package.json"),
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

          vim.lsp.enable("ts_ls")
        end,

        ["csharp_ls"] = function()
          vim.lsp.config("csharp_ls", {
            handlers = {
              ["textDocument/definition"] = require("csharpls_extended").handler,
              ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
            },
          })
          vim.lsp.enable("csharp_ls")
        end,
      })

      vim.lsp.config("denols", {
        root_markers = { "deno.json", "deno.jsonc" },
      })
      vim.lsp.enable("denols")

      vim.lsp.enable("gleam")

      -- -- Use LspAttach autocommand to only map the following keys
      -- -- after the language server attaches to the current buffer
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      --   callback = function(ev)
      --     local opts = { noremap = true, silent = true }
      --     vim.keymap.set("n", "<leader>lf", vim.lsp.buf.references, { desc = "LSP references" })
      --     vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
      --     vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
      --     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
      --     vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP goto definition" })
      --     vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { desc = "LSP goto type definition" })
      --     vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
      --     vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
      --
      --     -- Enable completion triggered by <c-x><c-o>
      --     -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      --   end,
      -- })
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
      automatic_installation = true,
    },
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
        separator = "  ",
        enable = false,
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
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    opts = {
      preset = "classic",
      options = {
        show_sources = {
          enabled = true,
          if_many = true,
        },
        throttle = 0,
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_all_diags_on_cursorline = true,
        enable_on_insert = true,
        break_line = {
          enabled = false,
          after = 30,
        },
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
