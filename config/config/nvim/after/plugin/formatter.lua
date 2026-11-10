-- Pick JS/TS formatters from the project's config files
---@param pattern string[]
---@return boolean
local function rc_file_exists(pattern)
  local rc_files = vim.fs.find(pattern, {
    upward = true,
    stop = vim.fn.getenv("HOME"),
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
  })
  return #rc_files > 0
end

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
}

local tailwind_rc_files = {
  "tailwind.config.js",
  "tailwind.config.mjs",
  "tailwind.config.ts",
}

local function js_formatters_for_project()
  local formatters = {}

  if rc_file_exists(prettier_rc_files) then
    -- table.insert(formatters, "prettier")
    -- prettierが遅いのでDaemonを試す
    table.insert(formatters, "prettierd")
  elseif rc_file_exists(biome_rc_files) then
    -- BiomeとPrettierがconflictしないようにする
    table.insert(formatters, "biome")
  end

  if rc_file_exists(tailwind_rc_files) then
    table.insert(formatters, "rustywind")
  end

  return formatters
end

local js_formatters = js_formatters_for_project()

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

        cs = {
          inherit = false,
          command = "dotnet",
          args = { "format", "--include", vim.fn.expand("%") },
        },

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
      format_on_save = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
    })
  end,
})
