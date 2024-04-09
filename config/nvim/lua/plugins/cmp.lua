return {
  "hrsh7th/nvim-cmp",
  event = { "LspAttach", "InsertEnter", "CmdlineEnter" },
  dependencies = {
    { "hrsh7th/cmp-nvim-lsp", event = "LspAttach" },
    { "hrsh7th/cmp-nvim-lsp-signature-help", event = "LspAttach" },
    { "hrsh7th/cmp-buffer", event = "InsertEnter" },
    { "hrsh7th/cmp-path", event = "InsertEnter" },
    { "hrsh7th/cmp-cmdline", event = "CmdlineEnter" },
    { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "CmdlineEnter" },
    {
      "saadparwaiz1/cmp_luasnip",
      dependencies = "L3MON4D3/LuaSnip",
      event = "InsertEnter",
    },
    { "onsails/lspkind-nvim" },
    {
      "roobert/tailwindcss-colorizer-cmp.nvim",
      opts = {
        color_square_width = 2,
      },
    },
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
      },
      formatting = {
        format = require("tailwindcss-colorizer-cmp").formatter,
      },
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-g>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline({ "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
      }, {
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
