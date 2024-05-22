return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { ";f", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
      { ";g", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
      { ";b", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
      { ";d", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostics" },
      { ";c", "<cmd>Telescope command_history<cr>", desc = "Telescope command history" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
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
          command_history = {
            theme = "ivy",
          },
        },
      })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { ";;", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Telescope file browser" },
    },
    opts = {
      theme = "ivy",
      hijack_netrw = true,
      initial_mode = "normal",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup({ extensions = { file_browser = opts } })
      telescope.load_extension("file_browser")
    end,
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { ";e", "<cmd>Telescope emoji<cr>", desc = "Telescope emoji" },
    },
    opts = {
      action = function(emoji)
        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)
        vim.api.nvim_put({ emoji.value }, "c", false, true)
      end,
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup({ extensions = { emoji = opts } })
      telescope.load_extension("emoji")
    end,
  },
  {
    "chip/telescope-software-licenses.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { ";w", "<cmd>Telescope software-licenses find<cr>", desc = "Telescope software license" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension("software-licenses")
    end,
  },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      "stevearc/dressing.nvim",
    },
    opts = {},
  },
}
