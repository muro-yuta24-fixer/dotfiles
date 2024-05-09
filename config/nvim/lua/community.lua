-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder

  -- Colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  -- Indent rainbow
  { import = "astrocommunity.indent.indent-blankline-nvim" },

  -- Highlight args
  { import = "astrocommunity.syntax.hlargs-nvim" },

  -- Notification
  { import = "astrocommunity.utility.noice-nvim" },

  -- Telescope file browser
  { import = "astrocommunity.file-explorer.telescope-file-browser-nvim" },

  -- Treesitter utils
  { import = "astrocommunity.editing-support.nvim-treesitter-context" },
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" },

  -- Highlight TODO
  { import = "astrocommunity.editing-support.todo-comments-nvim" },

  -- Auto save
  { import = "astrocommunity.editing-support.auto-save-nvim" },

  -- LSP utils
  { import = "astrocommunity.lsp.inc-rename-nvim" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.lsp.lsplinks-nvim" },
  { import = "astrocommunity.lsp.actions-preview-nvim" },
  { import = "astrocommunity.diagnostics/trouble-nvim" },

  -- Languages
  { import = "astrocommunity.pack.cs" },
  { import = "astrocommunity.pack.docker" },

  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.vue" },

  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.terraform" },

  { import = "astrocommunity.pack.markdown" },

  { import = "astrocommunity.pack.fish" },

  -- Highlight color
  { import = "astrocommunity.color.nvim-highlight-colors" },

  -- Code runner
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- Jump
  { import = "astrocommunity.motion.hop-nvim" },
}
