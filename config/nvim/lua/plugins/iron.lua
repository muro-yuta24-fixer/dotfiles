return {
  "Vigemus/iron.nvim",
  keys = {
    { "<leader>rs", "<cmd>IronRepl<cr>", desc = "IronRepl" },
    { "<leader>rr", "<cmd>IronRestart<cr>", desc = "IronRestart" },
    { "<leader>rf", "<cmd>IronFocus<cr>", desc = "IronFocus" },
    { "<leader>rh", "<cmd>IronHide<cr>", desc = "IronHide" },
  },
  config = function()
    -- Default config
    local iron = require("iron.core")

    iron.setup({
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "fish" },
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = require("iron.view").bottom(40),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<leader>sc",
        visual_send = "<leader>sc",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        send_until_cursor = "<leader>su",
        send_mark = "<leader>sm",
        mark_motion = "<leader>mc",
        mark_visual = "<leader>mc",
        remove_mark = "<leader>md",
        cr = "<leader>s<cr>",
        interrupt = "<leader>s<leader>",
        exit = "<leader>sq",
        clear = "<leader>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })
  end,
}
