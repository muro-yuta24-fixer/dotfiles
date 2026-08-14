{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    herdr
  ];

  xdg.configFile."herdr/config.toml".source = ./herdr/config.toml;
}
