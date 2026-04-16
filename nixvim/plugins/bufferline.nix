{ lib, pkgs, ... }:

{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        mode = "tabs";
        numbers = "buffer_id";
        indicator = {
          style = "icon";
        };
        buffer_close_icon = "󰅖";
        modified_icon = "●";
        close_icon = "";
        left_trunc_marker = "";
        right_trunc_marker = "";
        diagnostics = "nvim_lsp";
        offsets = { };
        color_icons = true;
        show_buffer_icons = true;
        show_buffer_close_icons = false;
        show_close_icons = false;
        show_tab_indicators = false;
        show_duplicate_prefix = false;
        separator_style = "slant";
        always_show_bufferline = true;
        sort_by = "tabs";
      };
    };
  };
}
