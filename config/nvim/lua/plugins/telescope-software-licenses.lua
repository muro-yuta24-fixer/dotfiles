return {
  "chip/telescope-software-licenses.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function() require("telescope").load_extension("software-licenses") end,
}
