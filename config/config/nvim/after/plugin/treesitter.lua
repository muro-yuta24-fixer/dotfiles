require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    require("treesitter-context").setup({})

    require("aerial").setup({})
    require("telescope").load_extension("aerial")
  end,
})

vim.keymap.set("n", "<leader>ar", "<cmd>Telescope aerial<cr>", { desc = "Telescope aerial" })
