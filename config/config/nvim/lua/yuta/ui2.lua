-- Built-in message / cmdline UI (replaces noice.nvim + nvim-notify)
-- NOTE: experimental in Nvim 0.12. See :h ui2
local ok, ui2 = pcall(require, "vim._core.ui2")
if not ok then
  return
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "msg",
  callback = function() vim.api.nvim_win_set_config(0, { border = "single" }) end,
})

ui2.enable({
  msg = {
    targets = "msg",
    msg = {
      timeout = 3000,
    },
  },
})
