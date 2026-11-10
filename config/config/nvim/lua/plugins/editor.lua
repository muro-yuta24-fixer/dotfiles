local later = require("utils.defer").later

later(function()
  require("nvim-autopairs").setup({})
  require("nvim-ts-autotag").setup({})
  require("hop").setup({})
end)

vim.keymap.set({ "n", "v" }, "<c-space>", "<cmd>HopWord<cr>", { desc = "Hop word" })
