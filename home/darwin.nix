{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 13;
        normal.family = "PlemolJP Console NF";
        bold.family = "PlemolJP Console NF";
        italic.family = "PlemolJP Console NF";
        bold_italic.family = "PlemolJP Console NF";
      };
    };
  };
}
