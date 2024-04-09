local builtins = require("conform-selector.builtins")
local js_formatters = builtins.javascript.formatters()

return {
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
      javascript = js_formatters,
      javascriptreact = js_formatters,
      typescript = js_formatters,
      typescriptreact = js_formatters,
      svelte = js_formatters,
      astro = js_formatters,

      json = { "jq" },
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
}
