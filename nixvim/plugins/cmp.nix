{ lib, pkgs, ... }:

{
  programs.nixvim.plugins.blink-cmp = {
    enable = true;
    setupLspCapabilities = true;
    settings = {
      keymap = {
        preset = "super-tab";
      };
      appearance = {
        nerd_font_variant = "normal";
      };
      completion = {
        accept = {
          auto_brackets = {
            enabled = true;
          };
        };
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 100;
          treesitter_highlighting = true;
          update_delay_ms = 50;
          window = {
            border = "rounded";
            scrollbar = true;
          };
        };
        ghost_text = {
          enabled = true;
        };
        menu = {
          enabled = true;
          auto_show = true;
          border = "rounded";
        };
      };
      fuzzy = {
        prebuilt_binaries = {
          download = true;
        };
      };
      signature = {
        enabled = true;
        window = {
          border = "rounded";
        };
      };
      sources = {
        default = [
          "lsp"
          "snippets"
          "buffer"
        ];
        per_filetype = {
          bash = [
            "buffer"
            "path"
          ];
          sh = [
            "buffer"
            "path"
          ];
        };
      };
    };
  };
}
