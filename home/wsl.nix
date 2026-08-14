{ config, pkgs, ... }:

let
  browser = "/mnt/c/Program\\ Files\\ \\(x86\\)/Microsoft/Edge/Application/msedge.exe";
in

{
  imports = [
    ./herdr.nix
  ];

  home.sessionVariables.BROWSER = browser;

  programs.zsh.sessionVariables.BROWSER = browser;

  programs.gh.settings.browser = browser;
}
