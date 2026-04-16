{ lib, pkgs, ... }:

{
  programs.nixvim = {
    plugins.lspsaga = {
      enable = true;
      settings = {
        lightbulb.enable = false;
        finder = {
          layout = "float";
          silent = false;
          keys = {
            toggleOrOpen = "o";
            vsplit = "<C-v>";
            tabnew = "<C-t>";
            quit = "q";
          };
        };
        rename = {
          inSelect = true;
          autoSave = true;
          keys = {
            exec = "<CR>";
            quit = "<ESC>";
          };
        };
        codeAction = {
          numShortcut = true;
          showServerName = true;
          extendGitsigns = false;
          keys = {
            quit = "q";
            exec = "<CR>";
          };
        };
        symbolInWinbar = {
          separator = "  ";
          enable = true;
          showFile = true;
        };
        diagnostic = {
          showCodeAction = true;
          keys = {
            quit = "q";
          };
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>lf";
        action = "<cmd>Lspsaga finder<cr>";
        options.desc = "Lspsaga finder";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>Lspsaga rename<cr>";
        options.desc = "Lspsaga rename";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<cr>";
        options.desc = "Hover doc";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>Lspsaga code_action<cr>";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "gd";
        action = "<cmd>Lspsaga goto_definition<cr>";
        options.desc = "Goto definition";
      }
      {
        mode = "n";
        key = "gD";
        action = "<cmd>Lspsaga goto_type_definition<cr>";
        options.desc = "Goto type definition";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<cmd>Lspsaga diagnostic_jump_next<cr>";
        options.desc = "Next diagnostic";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Lspsaga show_line_diagnostics<cr>";
        options.desc = "Line diagnostics";
      }
    ];
  };
}
