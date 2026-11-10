local M = {}

---Run `fn` right after startup (replacement for lazy.nvim's "VeryLazy" event)
---@param fn fun()
M.later = function(fn)
  if vim.v.vim_did_enter == 1 then
    vim.schedule(fn)
    return
  end
  vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function() vim.schedule(fn) end,
  })
end

return M
