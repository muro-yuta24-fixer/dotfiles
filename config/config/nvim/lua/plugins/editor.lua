return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "svelte",
      "astro",
      "vue",
      "cs",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = true,
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    keys = {
      { "<leader><leader>", "<cmd>HopWord<cr>", desc = "Hop word", mode = { "n", "v" } },
    },
    opts = {},
  },
}
