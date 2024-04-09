return {
  "RRethy/vim-illuminate",
  event = "BufRead",
  opts = {
    providers = {
      "lsp",
      "treesitter",
    },
  },
  config = function(_, opts) require("illuminate").configure(opts) end,
}
