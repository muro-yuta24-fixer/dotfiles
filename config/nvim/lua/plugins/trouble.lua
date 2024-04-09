return {
  "folke/trouble.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>tr", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Show workspace diagnostics" },
  },
  opts = {
    position = "bottom",
    height = 20,
    action_keys = {
      close = { "q", "<esc>" },
      cancel = {},
    },
    use_diagnostics_signs = true,
  },
}
