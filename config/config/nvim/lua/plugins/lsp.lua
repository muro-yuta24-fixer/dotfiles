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
local later = require("utils.defer").later

require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = ensure_installed.lsp,
  automatic_enable = {
    exclude = {
      "denols",
      "ts_ls",
      "basedpyright",
      "gleam",
    },
  },
})

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

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

---@module 'roslyn.config'
---@type RoslynNvimConfig
require("roslyn").setup({
  -- your configuration comes here; leave empty for default settings
})

later(function()
  require("mason-tool-installer").setup({
    auto_update = true,
    run_on_start = true,
  })

  require("conform").setup({
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
  })
end)
