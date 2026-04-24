{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;
      font = {
        size = 14;
        normal.family = "PlemolJP Console NF";
        bold.family = "PlemolJP Console NF";
        italic.family = "PlemolJP Console NF";
        bold_italic.family = "PlemolJP Console NF";
      };
    };
  };
}
