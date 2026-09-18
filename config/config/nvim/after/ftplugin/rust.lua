local bufnr = vim.api.nvim_get_current_buf()
local opts = { silent = true, buffer = bufnr }

vim.keymap.set("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, opts)
vim.keymap.set("n", "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, opts)
vim.keymap.set("n", "<leader>e", function() vim.cmd.RustLsp({ "renderDiagnostic", "current" }) end, opts)
