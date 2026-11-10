vim.loader.enable()

-- init.lua runs before plugins. Everything else lives in:
--   plugin/        built-in features (keymaps, autocmds, statusline, LSP keymaps, ...)
--   after/plugin/  plugin configs (run after the plugins' own plugin/ scripts)

----------------------------------------------------------------------
-- Options
----------------------------------------------------------------------
vim.cmd("autocmd!")

vim.g.mapleader = " "

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true
vim.wo.relativenumber = true

vim.opt.shell = "fish"

vim.opt.title = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.updatetime = 200 -- CursorHold delay (used for LSP document highlight)
vim.opt.backupskip = "/etc/*,/usr/bin/*,/usr/share/*,/usr/src/*"
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true -- Auto indent
vim.opt.smartindent = true -- Smart indent
vim.opt.wrap = true -- Wrap lines
vim.opt.backspace = "start,eol,indent"
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*", "*/venv/*", "*/.venv/*" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Turn off paste mode when leaving insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Highlight settings
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "light"

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

----------------------------------------------------------------------
-- UI
----------------------------------------------------------------------
-- Built-in message / cmdline UI (replaces noice.nvim + nvim-notify)
-- NOTE: experimental in Nvim 0.12. See :h ui2
local ok, ui2 = pcall(require, "vim._core.ui2")
if ok then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "msg",
    callback = function() vim.api.nvim_win_set_config(0, { border = "single" }) end,
  })

  ui2.enable({
    msg = {
      targets = "msg",
      msg = {
        timeout = 3000,
      },
    },
  })
end

----------------------------------------------------------------------
-- Plugins
----------------------------------------------------------------------
-- Plugin manager: vim.pack (built-in, Neovim 0.12+)
-- Lockfile: nvim-pack-lock.json (config dir)

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
