{ config, pkgs, ... }:

{
  imports = [
    ./herdr.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 12;
        normal.family = "PlemolJP Console NF";
        bold.family = "PlemolJP Console NF";
        italic.family = "PlemolJP Console NF";
        bold_italic.family = "PlemolJP Console NF";
      };
      window = {
        dimensions = {
          columns = 160;
          lines = 40;
        };
      };
    };
  };

  xdg.configFile."containers/containers.conf".text = ''
    [machine]
    provider = "applehv"
  '';
}
