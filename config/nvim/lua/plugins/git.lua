return {
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    keys = {
      { "<leader>ng", "<cmd>Neogit kind=tab<cr>", desc = "Launch neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
  },
  {
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
  },
  {
    "akinsho/git-conflict.nvim",
    -- cmd = {
    --   "GitConflictRefresh",
    --   "GitConflictChooseOurs",
    --   "GitConflictChooseTheirs",
    --   "GitConflictChooseBoth",
    --   "GitConflictChooseBase",
    --   "GitConflictChooseNone",
    --   "GitConflictNextConflict",
    --   "GitConflictPrevConflict",
    --   "GitConflictListQf",
    -- },
    event = "VeryLazy",
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
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      attach_to_untracked = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align",
        delay = 10,
      },
      current_line_blame_formatter = "<summary> by <author> (<author_time:%Y/%m/%d>)",
    },
  },
}
