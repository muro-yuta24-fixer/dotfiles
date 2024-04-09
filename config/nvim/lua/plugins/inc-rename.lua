return {
  "smjonas/inc-rename.nvim",
  cmd = "IncRename",
  keys = {
    {
      "<leader>rn",
      ":IncRename " .. vim.fn.expand("<cword>"),
      desc = "Rename symbol",
    },
  },
  config = true,
}
