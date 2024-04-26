return {
  {
    "nathom/filetype.nvim",
    lazy = false,
    enabled = true,
    opts = {},
    config = function(_, opts)
      vim.g.did_load_filetypes = 1

      require("filetype").setup(opts)
    end,
  },
}
