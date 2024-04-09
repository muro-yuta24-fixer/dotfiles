local ensure_installed = {
  "clangd",

  "rust_analyzer",

  "lua_ls",

  "dockerls",
  "docker_compose_language_service",

  "html",
  "cssls",
  "tsserver",
  "svelte",
  "astro",
  "tailwindcss",

  "biome",
  "eslint",

  "ruff_lsp",

  "taplo",
}

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- LSP Installer
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Completion from LSP
    "hrsh7th/cmp-nvim-lsp",
  },
  lazy = false,
  config = function()
    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_installation = false,
    })

    local lspconfig = require("lspconfig")

    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()

    require("mason-lspconfig").setup_handlers({

      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
          capabilities = cmp_capabilities,
        })
      end,

      ["denols"] = function()
        lspconfig["denols"].setup({
          capabilities = cmp_capabilities,
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        })
      end,

      ["tsserver"] = function()
        lspconfig["tsserver"].setup({
          capabilities = cmp_capabilities,
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
        })
      end,

      ["clangd"] = function()
        cmp_capabilities.offsetEncoding = "utf-8"
        lspconfig["clangd"].setup({
          capabilities = cmp_capabilities,
        })
      end,
    })
    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      end,
    })

    -- Customize how diagnostics are displayed
    vim.diagnostic.config({
      virtual_text = {
        prefix = require("utils.icons").prelude.bell,
        source = "always",
      },
      float = {
        source = "always",
      },
      signs = false,
      underline = true,
      update_in_insert = true,
      severity_sort = false,
    })

    -- Go to definition in a split window
    local function goto_definition(split_cmd)
      local util = vim.lsp.util
      local log = require("vim.lsp.log")
      local api = vim.api

      -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
      local handler = function(_, result, ctx)
        if result == nil or vim.tbl_isempty(result) then
          local _ = log.info() and log.info(ctx.method, "No location found")
          return nil
        end

        if split_cmd then
          vim.cmd(split_cmd)
        end

        if vim.tbl_islist(result) then
          util.jump_to_location(result[1])

          if #result > 1 then
            util.set_qflist(util.locations_to_items(result))
            api.nvim_command("copen")
            api.nvim_command("wincmd p")
          end
        else
          util.jump_to_location(result)
        end
      end

      return handler
    end

    vim.lsp.handlers["textDocument/definition"] = goto_definition("split")
  end,
}
