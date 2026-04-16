{ lib, pkgs, ... }:

{
  programs.nixvim.plugins = {
    noice = {
      enable = true;
      settings = {
        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          inc_rename = true;
          lsp_doc_border = true;
        };
        lsp = {
          hover.enabled = false;
          message.enabled = false;
          progress.enabled = false;
          signature = {
            enabled = false;
            auto_open.enabled = false;
          };
        };
        messages = {
          enabled = true;
        };
      };
    };
    notify = {
      enable = true;
      settings = { };
    };
  };
}
