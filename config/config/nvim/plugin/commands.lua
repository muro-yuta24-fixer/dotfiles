vim.api.nvim_create_user_command("T", function(opts)
  vim.cmd("split | wincmd j | resize 20")
  vim.cmd("terminal " .. opts.args)
end, { nargs = "*" })
