local later = require("utils.defer").later

require("nvim-treesitter").setup({})

later(function()
  require("treesitter-context").setup({})

  require("aerial").setup({})
  require("telescope").load_extension("aerial")
end)

vim.keymap.set("n", "<leader>ar", "<cmd>Telescope aerial<cr>", { desc = "Telescope aerial" })
