return {
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-g>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "LspAttach",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
    dependencies = {
      "hrsh7th/nvim-cmp",

      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local cmp = require("cmp")

      return {
        {
          type = ":",
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            { name = "cmdline" },
          }),
        },
        {
          type = "/",
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = "buffer" },
          }, {
            -- { name = "nvim_lsp_document_symbol" },
          }),
        },
        {
          type = "?",
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      vim.tbl_map(function(val) cmp.setup.cmdline(val.type, val) end, opts)
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2",
    build = "make install_jsregexp",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("snippets")

      require("cmp").setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
      })
    end,
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    opts = {
      color_square_width = 2,
    },
    config = function(_, opts)
      local tailwind_colorizer_cmp = require("tailwindcss-colorizer-cmp")

      tailwind_colorizer_cmp.setup(opts)

      require("cmp").setup({
        formatting = {
          format = tailwind_colorizer_cmp.formatter,
          fields = { "kind" },
          expandable_indicator = true,
        },
      })
    end,
  },
}
