return {
  "akinsho/git-conflict.nvim",
  cmd = {
    "GitConflictChooseOurs",
    "GitConflictChooseTheirs",
    "GitConflictChooseBoth",
    "GitConflictChooseNone",
    "GitConflictNextConflict",
    "GitConflictPrevConflict",
    "GitConflictListQf",
  },
  version = "*",
  opts = {},
  config = function(_, opts)
    require("git-conflict").setup(opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "GitConflictDetected",
      callback = function()
        vim.notify("Conflict detected in " .. vim.fn.expand("<afile>"))
        vim.keymap.set("n", "cww", function()
          engage.conflict_buster()
          create_buffer_local_mappings()
        end)
      end,
    })
  end,
}
