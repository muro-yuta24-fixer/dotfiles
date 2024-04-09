return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        mappings = {
          i = {
            -- Mappings for insert mode
            ["<C-g>"] = actions.close,
          },
          n = {
            -- Mappings for normal mode
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        oldfiles = {
          theme = "dropdown",
        },
        buffers = {
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer + actions.move_to_top,
            },
          },
        },
      },
    })
  end,
  keys = {
    { ";f", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
    { ";g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
    { ";b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
    { ";of", "<cmd>Telescope oldfiles<cr>", desc = "Telescope old files" },
    { ";d", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostics" },
    { ";gc", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
    { ";gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope git branches" },
    { ";s", "<cmd>Telescope treesitter<cr>", desc = "Telescope treesitter" },
  },
}
