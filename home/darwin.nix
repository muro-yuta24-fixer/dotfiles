{ config, pkgs, ... }:

{
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
    };
  };

  xdg.configFile."containers/containers.conf".text = ''
    [machine]
    provider = "applehv"
  '';

  xdg.configFile."herdr/config.toml".source = ./herdr/config.toml;
}
