local prettier_rc_files = {
  ".prettierrc",
  ".prettierrc.json",
  ".prettierrc.json5",
  ".prettierrc.yml",
  ".prettierrc.yaml",
  ".prettierrc.js",
  "prettier.config.js",
  ".prettierrc.mjs",
  "prettier.config.mjs",
  ".prettierrc.cjs",
  "prettier.config.cjs",
  ".prettierrc.toml",
}

local biome_rc_files = {
  "biome.json",
  "biome.jsonc",
}

local tailwind_rc_files = {
  "tailwind.config.js",
  "tailwind.config.mjs",
  "tailwind.config.ts",
}

---Whether one of `names` exists in the buffer's directory or its parents (up to $HOME)
---@param bufnr integer
---@param names string[]
---@return boolean
local function rc_file_exists(bufnr, names)
  local found = vim.fs.find(names, {
    upward = true,
    stop = vim.env.HOME,
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)),
  })
  return #found > 0
end

---Pick JS/TS formatters from the config files of the buffer's project.
---Evaluated per buffer on each format, so it follows the project being edited.
---@param bufnr integer
---@return string[]
local function js_formatters(bufnr)
  local formatters = {}

  if rc_file_exists(bufnr, prettier_rc_files) then
    -- prettierが遅いのでDaemonを使う
    table.insert(formatters, "prettierd")
  elseif rc_file_exists(bufnr, biome_rc_files) then
    -- BiomeとPrettierがconflictしないようにする
    table.insert(formatters, "biome")
  end

  if rc_file_exists(bufnr, tailwind_rc_files) then
    table.insert(formatters, "rustywind")
  end

  return formatters
end

-- NOTE: not passed to mason-tool-installer yet
local tools = {
  -- Formatters
  "stylua",

  "yamlfmt",

  "biome",

  -- Linters
}

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    require("mason-tool-installer").setup({
      auto_update = true,
      run_on_start = true,
    })

    require("conform").setup({
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },

        -- cs: formatted by roslyn (LSP fallback)

        lua = { "stylua" },

        html = js_formatters,
        css = js_formatters,
        scss = js_formatters,
        javascript = js_formatters,
        javascriptreact = js_formatters,
        typescript = js_formatters,
        typescriptreact = js_formatters,
        svelte = js_formatters,
        astro = js_formatters,
        vue = js_formatters,

        -- json = { "jq" },
        -- jsonc = { "jq" },
        toml = { "taplo" },
        -- yaml = { "yamlfmt" },

        fish = { "fish_indent" },
        sh = { "beautysh" },
      },
      default_format_opts = {
        lsp_format = "fallback", -- use LSP when no formatter is configured / available
      },
      format_on_save = {
        timeout_ms = 10000,
      },
    })
  end,
})
