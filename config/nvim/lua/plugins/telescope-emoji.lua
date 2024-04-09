return {
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
}
