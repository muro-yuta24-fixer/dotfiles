local ensure_installed = {
  lsp = {
    "lua_ls",

    "dockerls",
    "docker_compose_language_service",

    -- "csharp_ls",
    -- "omnisharp",

    "vtsls",
    "vue_ls",

    "basedpyright",
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

local configure_lsp = require("utils.lsp-config-wrapper").configure_lsp

return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
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
          "basedpyright",
          "gleam",
        },
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local vue_typescript_plugin = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")

      configure_lsp("vtsls", {
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_typescript_plugin,
                  languages = { "vue" },
                },
              },
            },
          },
        },
      })

      configure_lsp("basedpyright", {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "strict",
            },
          },
        },
      })

      configure_lsp("gleam", {})
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
    -- Code action picker with diff preview
    "aznhe21/actions-preview.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = function()
      local hl = require("actions-preview.highlight")

      -- delta with the git config colors, but unified (not side-by-side) for the small preview
      local delta = hl.delta([[env "GIT_CONFIG_PARAMETERS='delta.side-by-side=false'" delta --paging=never]])
      delta.is_available = function() return vim.fn.executable("delta") == 1 end

      -- Own nui backend: preview pane only when the action has a diff (lua/utils/actions-preview-compact.lua)
      package.loaded["actions-preview.backend.compact"] = require("utils.actions-preview-compact")

      return {
        backend = { "compact" },
        highlight_command = { delta },
        compact = {
          border = "single",
          width = 0.6, -- of editor columns
          min_width = 60,
          max_list_height = 8,
          preview_height = 0.35, -- of editor lines
          keymap = {
            focus_next = { "j", "<Down>", "<Tab>", "<C-n>" },
            focus_prev = { "k", "<Up>", "<S-Tab>", "<C-p>" },
            close = { "<Esc>", "<C-c>", "q" },
            submit = { "<CR>", "<Space>" },
          },
        },
      }
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {
      -- Save every buffer touched by the rename (like lspsaga's auto_save)
      post_hook = function(result)
        local uris = {}
        for uri in pairs(result.changes or {}) do
          uris[uri] = true
        end
        for _, change in ipairs(result.documentChanges or {}) do
          if change.textDocument then
            uris[change.textDocument.uri] = true
          end
        end
        for uri in pairs(uris) do
          local buf = vim.uri_to_bufnr(uri)
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].modified then
            vim.api.nvim_buf_call(buf, function() vim.cmd("silent update") end)
          end
        end
      end,
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

        -- json = { "jq" },
        -- jsonc = { "jq" },
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
    "folke/lazydev.nvim",
    ft = { "lua" },
    opts = {
      library = {
        "lazy.nvim",
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
}
