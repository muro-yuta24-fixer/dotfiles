return {
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
}
