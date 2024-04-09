return {
  "nvimdev/lspsaga.nvim",
  event = "LspAttach",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "Lspsaga" },
  keys = {
    { "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Lspsaga finder" },
    -- { "<leader>rn", "<cmd>Lspsaga rename<cr>", desc = "Lspsaga rename" },
    { "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover doc" },
    { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code action" },
    { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto definition" },
    { "gD", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto type definition" },
    { "<C-j>", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Goto next diagnostics" },
    { "<leader>e", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Show line diagnostics" },
  },
  opts = {
    lightbulb = {
      enable = false,
    },
    finder = {
      layout = "float",
      silent = false,
      keys = {
        toggle_or_open = { "o", "<space>" },
        vsplit = { "<C-v>" },
        tabnew = { "<C-t>" },
        quit = { "q", "<ESC>" },
      },
    },
    rename = {
      in_select = true,
      auto_save = true,
      keys = {
        exec = { "<CR>" },
        quit = { "<ESC>" },
      },
    },
    hover_doc = {
      open_cmd = "!wslview",
    },
    code_action = {
      num_shortcut = true,
      show_server_name = true,
      extend_gitsigns = false,
      keys = {
        quit = { "q", "<ESC>" },
        exec = { "<CR>" },
      },
    },
    symbol_in_winbar = {
      enable = false,
      separator = "  ",
      show_file = true,
    },
    diagnostics = {
      show_code_action = true,
      keys = {
        quit = { "q", "<ESC>" },
      },
    },
  },
}
