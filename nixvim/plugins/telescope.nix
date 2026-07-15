{ lib, pkgs, ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      ";f" = {
        action = "find_files";
        options = {
          desc = "Telescope find files";
        };
      };
      ";g" = {
        action = "live_grep";
        options = {
          desc = "Telescope live grep";
        };
      };
      ";b" = {
        action = "buffers";
        options = {
          desc = "Telescope buffers";
        };
      };
      ";c" = {
        action = "command_history";
        options = {
          desc = "Telescope command history";
        };
      };
      ";;" = {
        action = "file_browser path=%:p:h select_buffer=true";
        options = {
          desc = "Telescope file browser";
        };
      };
    };
    extensions = {
      file-browser = {
        enable = true;
        settings = {
          hijack_netrw = true;
          theme = "dropdown";
          initial_mode = "normal";
        };
      };
    };
    settings = {
      defaults = {
        mappings = {
          i = {
            "<C-g>" = {
              __raw = "require('telescope.actions').close";
            };
          };
          n = {
            "q" = {
              __raw = "require('telescope.actions').close";
            };
          };
        };
      };
      pickers = {
        find_files = {
          find_command = [
            "rg"
            "--files"
            "--hidden"
            "--glob"
            "!**/.git/*"
          ];
        };
        buffers = {
          mappings = {
            i = {
              "<C-d>" = {
                __raw = "require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top";
              };
            };
          };
        };
      };
    };
  };
}
