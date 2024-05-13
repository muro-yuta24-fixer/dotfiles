return {
  {
    "nathom/filetype.nvim",
    lazy = false,
    enabled = true,
    opts = {},
    init = function()
      vim.g.did_load_filetypes = 1
    end,
  },
}
