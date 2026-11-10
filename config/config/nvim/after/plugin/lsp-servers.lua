local servers = {
  "lua_ls",

  "dockerls",
  "docker_compose_language_service",

  -- "csharp_ls",
  -- "omnisharp",

  "vtsls",
  "vue_ls",

  "basedpyright",
}

---@param name string
---@param opts vim.lsp.Config
local function configure_lsp(name, opts)
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

require("mason").setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
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

---@module 'roslyn.config'
---@type RoslynNvimConfig
require("roslyn").setup({
  -- your configuration comes here; leave empty for default settings
})
