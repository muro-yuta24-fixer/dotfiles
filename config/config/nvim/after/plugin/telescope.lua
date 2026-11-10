vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        file_browser = {
          theme = "ivy",
          hijack_netrw = false,
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

    telescope.load_extension("file_browser")
    telescope.load_extension("undo")
    telescope.load_extension("emoji")
    telescope.load_extension("software_licenses")
  end,
})

local function map(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = desc }) end

map(";f", "<cmd>Telescope find_files<cr>", "Telescope find files")
map(";g", "<cmd>Telescope live_grep<cr>", "Telescope live grep")
map(";b", "<cmd>Telescope buffers<cr>", "Telescope buffers")
map(";c", "<cmd>Telescope command_history<cr>", "Telescope command history")
map("<leader>lf", "<cmd>Telescope lsp_references<cr>", "LSP references")
map("<leader>li", "<cmd>Telescope lsp_implementations<cr>", "LSP implementations")
map(";;", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", "Telescope file browser")
map(";u", "<cmd>Telescope undo<cr>", "Telescope history")
map(";e", "<cmd>Telescope emoji<cr>", "Telescope emoji")
