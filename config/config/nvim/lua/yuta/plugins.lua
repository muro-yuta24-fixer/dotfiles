-- Plugin manager: vim.pack (built-in, Neovim 0.12+)
-- Lockfile: nvim-pack-lock.json (config dir)

vim.g.loaded_netrwPlugin = 1

local function gh(repo) return "https://github.com/" .. repo end

-- Build hooks. Must be registered before vim.pack.add() so they also run on install.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("pack_hooks", { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path })
    elseif name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  -- Libraries
  gh("nvim-lua/plenary.nvim"),
  gh("nvim-neotest/nvim-nio"),
  gh("nvim-tree/nvim-web-devicons"),

  -- UI
  gh("craftzdog/solarized-osaka.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("folke/which-key.nvim"),
  gh("b0o/incline.nvim"),

  -- Completion
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
  gh("Dynge/gitmoji.nvim"),

  -- LSP / formatter
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
  gh("mason-org/mason-lspconfig.nvim"),
  gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
  gh("stevearc/conform.nvim"),
  gh("folke/lazydev.nvim"),
  gh("seblyng/roslyn.nvim"),

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  gh("nvim-treesitter/nvim-treesitter-context"),
  gh("stevearc/aerial.nvim"),

  -- Editor
  gh("windwp/nvim-autopairs"),
  gh("windwp/nvim-ts-autotag"),
  { src = gh("smoka7/hop.nvim"), version = vim.version.range("*") },

  -- Git
  { src = gh("akinsho/git-conflict.nvim"), version = vim.version.range("*") },
  gh("lewis6991/gitsigns.nvim"),

  -- Telescope
  { src = gh("nvim-telescope/telescope.nvim"), version = vim.version.range("*") },
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  gh("nvim-telescope/telescope-file-browser.nvim"),
  gh("debugloop/telescope-undo.nvim"),
  gh("xiyaowong/telescope-emoji.nvim"),
  gh("chip/telescope-software-licenses.nvim"),

  -- Debug
  gh("mfussenegger/nvim-dap"),
  gh("mfussenegger/nvim-dap-python"),
  gh("jay-babu/mason-nvim-dap.nvim"),
  gh("igorlfs/nvim-dap-view"),

  -- Test
  gh("nvim-neotest/neotest"),
  gh("fredrikaverpil/neotest-golang"),
  gh("Issafalcon/neotest-dotnet"),
})

-- Plugin configs (order matters: colorscheme first, telescope before aerial)
require("plugins.ui")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.editor")
require("plugins.git")
require("plugins.incline")
require("plugins.debug")
require("plugins.test")

-- :PackUpdate [names...]  update plugins (shows a confirmation buffer)
vim.api.nvim_create_user_command("PackUpdate", function(opts) vim.pack.update(#opts.fargs > 0 and opts.fargs or nil) end, {
  nargs = "*",
  complete = function()
    return vim.tbl_map(function(p) return p.spec.name end, vim.pack.get(nil, { info = false }))
  end,
  desc = "Update plugins",
})

-- :PackClean  remove plugins that are no longer listed in vim.pack.add()
vim.api.nvim_create_user_command("PackClean", function()
  local names = vim.iter(vim.pack.get(nil, { info = false })):filter(function(p) return not p.active end):map(function(p) return p.spec.name end):totable()
  if #names == 0 then
    vim.notify("PackClean: nothing to remove")
    return
  end
  vim.pack.del(names)
  vim.notify("PackClean: removed " .. table.concat(names, ", "))
end, { desc = "Remove unused plugins" })
