local M = {}

---wrapper to configure LSP
---@param name string
---@param opts vim.lsp.Config
M.configure_lsp = function(name, opts)
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

return M
