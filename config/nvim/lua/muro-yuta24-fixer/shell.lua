if vim.fn.has("win32") == 1 then
  vim.opt.shell = "pwsh"
else
  vim.opt.shell = "fish"
end
