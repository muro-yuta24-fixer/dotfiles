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
          hover.enabled = true;
          message.enabled = true;
          progress.enabled = true;
          signature = {
            enabled = true;
            auto_open.enabled = true;
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
