return {
  "Dynge/gitmoji.nvim",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  opts = {
    filetypes = { "gitcommit", "NeogitCommitMessage" },
    completion = {
      append_space = true,
    },
  },
  ft = { "gitcommit", "NeogitCommitMessage" },
}
