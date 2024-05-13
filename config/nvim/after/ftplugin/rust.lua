local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true, buffer = bufnr }

-- vim.keymap.set("n", "<leader>a", function() vim.cmd.RustLsp("codeAction") end, opts)

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      -- keymaps
    end,
    default_settings = {
      ["rust-analyzer"] = {
        --
      },
    },
  },
}
