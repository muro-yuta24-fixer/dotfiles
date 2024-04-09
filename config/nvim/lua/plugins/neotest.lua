return {
  "nvim-neotest/neotest",
  keys = {
    { "<F6>", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test for current file" },
    { "<S-F6>", function() require("neotest").run.stop() end, desc = "Stop test" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-jest",
    "marilari88/neotest-vitest",
    "thenbe/neotest-playwright",
    "sidlatau/neotest-dart",
    "mrcjkb/rustaceanvim",
    "Issafalcon/neotest-dotnet",
    "MarkEmmons/neotest-deno",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-python"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path) return vim.fn.getcwd() end,
        }),
        require("neotest-vitest"),
        require("neotest-playwright").adapter({
          options = {
            persist_project_selection = true,
            enable_dynamic_test_discovery = true,
          },
        }),
        require("neotest-dart")({
          command = "flutter", -- Command being used to run tests. Defaults to `flutter`
          -- Change it to `fvm flutter` if using FVM
          -- change it to `dart` for Dart only tests
          use_lsp = true, -- When set Flutter outline information is used when constructing test name.
          -- Useful when using custom test names with @isTest annotation
          custom_test_method_names = {},
        }),
        require("rustaceanvim.neotest"),
        require("neotest-dotnet"),
        require("neotest-deno"),
      },
    })
  end,
}
