return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap" },
  keys = {
    { "<F12>", function() require("dapui").toggle() end },
  },
  config = true,
}
