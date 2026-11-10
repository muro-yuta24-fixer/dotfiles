-- Set mode to Insert when open built-in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function(ev)
    -- Only for terminals opened in a regular, focused window.
    -- Skips plugin previews (e.g. Telescope runs delta in a floating terminal),
    -- where startinsert would leak keys into the picker prompt.
    local win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_buf(win) ~= ev.buf or vim.api.nvim_win_get_config(win).relative ~= "" then
      return
    end
    vim.cmd.startinsert()
  end,
})

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
