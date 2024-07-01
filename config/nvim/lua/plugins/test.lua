local filetypes = require("utils.filetypes")

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "Neotest" },
    keys = {
      {
        "<F6>",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run test for current file",
      },
      {
        "<S-F6>",
        function()
          require("neotest").run.stop()
        end,
        desc = "Stop test",
      },
    },
  },
  {
    "Issafalcon/neotest-dotnet",
    dependencies = { "nvim-neotest/neotest" },
    ft = { "cs" },
    opts = {
      dap = {
        -- Extra arguments for nvim-dap configuration
        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
        args = { justMyCode = false },
        -- Enter the name of your dap adapter, the default value is netcoredbg
        adapter_name = "netcoredbg",
      },
      -- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
      -- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
      -- custom_attributes = {
      --   xunit = { "MyCustomFactAttribute" },
      --   nunit = { "MyCustomTestAttribute" },
      --   mstest = { "MyCustomTestMethodAttribute" },
      -- },
      -- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
      dotnet_additional_args = {
        "--verbosity detailed",
      },
      -- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
      -- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
      --       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
      discovery_root = "project", -- Default
    },
    config = function(_, opts)
      require("neotest").setup({ adapters = { require("neotest-dotnet")(opts) } })
    end,
  },
  {
    "nvim-neotest/neotest-jest",
    dependencies = { "nvim-neotest/neotest" },
    ft = filetypes.web,
    opts = {
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    },
    config = function(_, opts)
      require("neotest").setup({ adapters = { require("neotest-jest")(opts) } })
    end,
  },
}
