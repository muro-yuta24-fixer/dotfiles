vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    require("nvim-autopairs").setup({})
    require("nvim-ts-autotag").setup({})
    require("hop").setup({})
    require("todo-comments").setup({})
  end,
})

vim.keymap.set({ "n", "v" }, "<c-space>", "<cmd>HopWord<cr>", { desc = "Hop word" })
