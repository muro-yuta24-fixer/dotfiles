-- Customize how diagnostics are displayed
vim.diagnostic.config({
  virtual_text = {
    prefix = require("utils.icons").prelude.bell,
    source = "always",
  },
  float = {
    source = "always",
  },
  signs = false,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
})
