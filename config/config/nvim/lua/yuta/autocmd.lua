-- Set mode to Insert when open built-in terminal
vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })

-- Create parent directories on save (replaces mkdir.nvim)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(ev)
    if ev.match:match("^%w+://") then
      return
    end
    vim.fn.mkdir(vim.fn.fnamemodify(ev.match, ":p:h"), "p")
  end,
})
