local debuggers = {
  "coreclr",
}

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "GustavEikaas/easy-dotnet.nvim",
    },
    keys = {
      { "<C-F5>", function() require("dap").continue() end, desc = "Continue debug" },
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<F10>", function() require("dap").step_over() end, desc = "Step over" },
      { "<F11>", function() require("dap").step_into() end, desc = "Step into" },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    config = function()
      local mason_dap = require("mason-nvim-dap")

      mason_dap.setup({
        ensure_installed = debuggers,
        automatic_installation = false,
        handlers = {
          function(config)
            -- Automatic setup
            mason_dap.default_setup(config)
          end,

          coreclr = function(config)
            config.configurations = {
              options = {
                env = {
                  ASPNETCORE_ENVIRONMENT = "Development",
                },
              },
            }
            mason_dap.default_setup(config)
          end,
        },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      { "<F12>", function() require("dapui").toggle() end },
    },
    config = true,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
    config = true,
  },
}
