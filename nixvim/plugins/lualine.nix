{ lib, pkgs, ... }:

{
  programs.nixvim.plugins.lualine = {
    enable = true;
    settings = {
      options = {
        icons_enabled = true;
        theme = "auto";
        component_separators = {
          left = "";
          right = "";
        };
        section_separators = {
          left = "";
          right = "";
        };
        always_divide_middle = false;
        globalstatus = true;
        refresh = {
          statusline = 100;
          tabline = 100;
          winbar = 100;
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          {
            __unkeyed-1 = "diff";
            colored = true;
            symbols = {
              added = "[+]";
              modified = "[*]";
              removed = "[-]";
            };
          }
          {
            __unkeyed-1 = "filename";
            file_status = false;
            newfile_status = false;
            path = 1;
          }
        ];
        lualine_x = [
          "filetype"
          {
            __unkeyed-1 = "diagnostics";
            sources = [
              "nvim_diagnostic"
              "nvim_lsp"
            ];
            # symbols = {
            #   error = " "; # nf-oct-bug
            #   warn = " "; # nf-oct-alert
            #   info = " "; # nf-oct-info
            #   hint = " "; # nf-oct-light_bulb
            # };
            colored = true;
            update_in_insert = true;
            always_visible = true;
          }
        ];
        lualine_y = [
          "encoding"
          "fileformat"
        ];
        lualine_z = [
          "progress"
          "location"
        ];
      };
    };
  };
}
