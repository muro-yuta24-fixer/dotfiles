{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./common.nix ];

  system.stateVersion = "25.11";

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
  ];

  programs.nix-ld.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
