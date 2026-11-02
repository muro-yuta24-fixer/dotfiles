{ config, pkgs, ... }:

let
  browser = "/mnt/c/Users/室雄太/AppData/Local/Vivaldi/Application/vivaldi.exe";
in

{
  imports = [
    ./herdr.nix
  ];

  home.sessionVariables.BROWSER = browser;

  programs.zsh.sessionVariables.BROWSER = browser;

  programs.gh.settings.browser = browser;
}
