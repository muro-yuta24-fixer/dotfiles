local icons = require("utils.icons")

return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
        },
      },
      lualine_b = {
        {
          "branch",
        },
      },
      lualine_c = {
        {
          "diff",
          colored = true,
          symbols = icons.diff,
        },
        {
          "filename",
          file_status = false,
          newfile_status = false,
          path = 1,
          -- symbols = {},
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic", "nvim_lsp" },
          symbols = icons.diagnostics,
          colored = true,
          update_in_insert = true,
          always_visible = true,
        },
        {
          "overseer",
        },
      },
      lualine_y = {
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_z = { "progress", "location" },
    },
  },
}
