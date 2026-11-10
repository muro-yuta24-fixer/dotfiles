vim.loader.enable()

-- Loaded before plugins. Everything else lives in:
--   plugin/        built-in features (keymaps, autocmds, statusline, LSP keymaps, ...)
--   after/plugin/  plugin configs (run after the plugins' own plugin/ scripts)
require("yuta.options")
require("yuta.ui2")
require("yuta.pack")
