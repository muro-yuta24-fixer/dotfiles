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
    "akinsho/git-conflict.nvim",
    cmd = {
      "GitConflictRefresh",
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
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
    },
  },
  {
    "Dynge/gitmoji.nvim",
    ft = { "gitcommit", "oct", "NeogitCommit" },
    opts = {
      filetypes = { "gitcommit", "oct", "NeogitCommit" },
      completion = {
        append_space = true,
        complete_as = "emoji",
      },
    },
    config = function(_, opts)
      require("gitmoji").setup(opts)

      local cmp = require("cmp")

      cmp.setup.filetype({ "gitcommit", "oct", "NeogitCommitMessage" }, {
        sources = cmp.config.sources({
          { name = "gitmoji" },
        }),
      })
    end,
  },
}
