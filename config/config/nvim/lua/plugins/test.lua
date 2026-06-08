return {
  {
    "nvim-neotest/neotest",
    keys = {
      { "<F6>", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test for current file" },
      { "<S-F6>", function() require("neotest").run.stop() end, desc = "Stop test" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/nvim-nio",
    },
    opts = {},
  },
  {
    "fredrikaverpil/neotest-golang",
    ft = { "go" },
    dependencies = { "nvim-neotest/neotest" },
    opts = {
      go_test_args = { "-v", "-race", "-count=1" },
      testify_enabled = false,
      warn_test_name_daps = true,
      warn_test_no_excuted = true,
    },
    config = function(_, opts)
      require("neotest").setup({
        adapters = {
          require("neotest-golang")(opts),
        },
      })
    end,
  },
  {
    "Issafalcon/neotest-dotnet",
    ft = { "cs" },
    dependencies = { "nvim-neotest/neotest" },
    opts = {
      discovery_root = "project", -- Default
    },
    config = function(_, opts)
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet")(opts),
        },
      })
    end,
  },
}
