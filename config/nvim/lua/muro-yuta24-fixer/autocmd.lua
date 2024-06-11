-- Set mode to Insert when built-in Terminal opens
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
