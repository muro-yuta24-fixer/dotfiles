return {
  "nvim-telescope/telescope-file-browser.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "sf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Telescope file browser" },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = false,
          initial_mode = "normal",
        },
      },
    })
    telescope.load_extension("file_browser")
  end,
}
