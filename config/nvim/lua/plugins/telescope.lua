return {
  {

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
  },
  {
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
            theme = "ivy",
            hijack_netrw = false,
            initial_mode = "normal",
          },
        },
      })
      telescope.load_extension("file_browser")
    end,
  },
  {
    "debugloop/telescope-undo.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { ";u", "<cmd>Telescope undo<cr>", desc = "Telescope history" },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          undo = {},
        },
      })
      require("telescope").load_extension("undo")
    end,
  },
  {
    "xiyaowong/telescope-emoji.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          emoji = {
            action = function(emoji)
              vim.fn.setreg("*", emoji.value)
              print([[Press p or "*p to paste this emoji]] .. emoji.value)
              vim.api.nvim_put({ emoji.value }, "c", false, true)
            end,
          },
        },
      })
      telescope.load_extension("emoji")
    end,
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { ";q", "<cmd>Telescope frecency workspace=CWD<cr>", desc = "Telescope frecency" },
    },
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
  {
    "chip/telescope-software-licenses.nvim",
    cmd = { "Telescope" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("software-licenses")
    end,
  },
}
