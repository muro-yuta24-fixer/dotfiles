vim.lsp.inlay_hint.enable(true)

-- Diagnostics display
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
  float = { source = "if_many", border = "rounded" },
  severity_sort = true,
})

-- Workspace diagnostics in quickfix
vim.keymap.set("n", "<leader>tr", vim.diagnostic.setqflist, { desc = "Show workspace diagnostics" })
