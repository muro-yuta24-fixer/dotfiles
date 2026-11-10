local later = require("utils.defer").later

local builtins = require("conform-selector.builtins")
local js_formatters = builtins.javascript.formatters()

-- NOTE: not passed to mason-tool-installer yet
local tools = {
  -- Formatters
  "stylua",

  "yamlfmt",

  "biome",

  -- Linters
}

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
