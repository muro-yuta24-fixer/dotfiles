return {
  "https://codeberg.org/esensar/nvim-dev-container",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cmd = {
    "DevcontainerStart",
    "DevcontainerAttach",
    "DevcontainerExec",
    "DevcontainerStop",
    "DevcontainerStopAll",
    "DevcontainerRemoveAll",
    "DevcontainerLogs",
    "DevcontainerEditNearestConfig",
  },
  opts = {
    autocommands = {
      init = true,
      clean = true,
      update = true,
    },
  },
}
