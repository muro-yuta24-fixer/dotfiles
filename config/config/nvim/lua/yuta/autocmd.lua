-- Set mode to Insert when open built-in terminal
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
