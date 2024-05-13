return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = { "Telescope" },
    keys = {
      { ";f", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      { ";g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
      { ";b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
      { ";of", "<cmd>Telescope oldfiles<cr>", desc = "Telescope old files" },
      { ";d", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostics" },
      { ";gc", "<cmd>Telescope git_commits<cr>", desc = "Telescope git commits" },
      { ";gb", "<cmd>Telescope git_branches<cr>", desc = "Telescope git branches" },
      { ";s", "<cmd>Telescope treesitter<cr>", desc = "Telescope treesitter" },

      { "sf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Telescope file browser" },
      { ";u", "<cmd>Telescope undo<cr>", desc = "Telescope history" },
      { ";q", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Telescope frecency" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",

      "nvim-telescope/telescope-file-browser.nvim",
      "debugloop/telescope-undo.nvim",
      "xiyaowong/telescope-emoji.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "chip/telescope-software-licenses.nvim",
      "stevearc/aerial.nvim",
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            -- Mappings for insert mode
            ["<C-g>"] = require("telescope.actions").close,
          },
          n = {
            -- Mappings for normal mode
            ["q"] = require("telescope.actions").close,
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
              ["<C-d>"] = require("telescope.actions").delete_buffer + require("telescope.actions").move_to_top,
            },
          },
        },
      },
      extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          initial_mode = "normal",
        },
        undo = {},
        emoji = {
          action = function(emoji)
            vim.fn.setreg("*", emoji.value)
            print([[Press p or "*p to paste this emoji]] .. emoji.value)
            vim.api.nvim_put({ emoji.value }, "c", false, true)
          end,
        },
      },
    },
    init = function()
      local telescope = require("telescope")

      telescope.load_extension("file_browser")
      telescope.load_extension("undo")
      telescope.load_extension("emoji")
      telescope.load_extension("frecency")
      telescope.load_extension("software-licenses")
      telescope.load_extension("aerial")
    end,
  },
}
