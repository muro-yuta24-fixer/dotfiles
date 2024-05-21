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
    ft = { "gitcommit", "octo", "NeogitCommitMessage" },
    opts = {
      filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
      completion = {
        append_space = true,
      },
    },
    config = function(_, opts)
      local cmp = require("cmp")

      cmp.setup.filetype({ "gitcommit", "octo", "NeogitCommitMessage" }, {
        sources = cmp.config.sources({
          { name = "gitmoji" },
        }, {
          { name = "buffer" },
        }),
      })

      require("gitmoji").setup(opts)
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictRefresh",
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseBase",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
    },
    version = "*",
    opts = {},
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
