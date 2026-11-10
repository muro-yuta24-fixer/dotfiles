-- Indent guides with 'listchars' (replaces indent-blankline.nvim)
local guide = "▎"

vim.opt.list = true

local function update_indent_guide()
  local width = vim.fn.shiftwidth()
  vim.opt_local.listchars = {
    tab = guide .. " ",
    nbsp = "+",
    leadmultispace = guide .. string.rep(" ", width - 1),
  }
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
  group = vim.api.nvim_create_augroup("indent_guide", { clear = true }),
  callback = update_indent_guide,
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = "indent_guide",
  pattern = { "shiftwidth", "tabstop" },
  callback = update_indent_guide,
})
