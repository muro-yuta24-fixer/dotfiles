return {
  {
    "stevearc/overseer.nvim",
    enabled = true,
    cmd = {
      "OverseerOpen",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
      "OverseerBuild",
      "OverseerQuickAction",
      "OverseerTaskAction",
      "OverseerClearCache",
    },
    keys = {
      { "<F5>", "<cmd>OverseerRun<cr>", desc = "Run a task" },
    },
    opts = {},
  },
}
