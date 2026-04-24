{
  config,
  lib,
  pkgs,
  ...
}:

{
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

  nix.package = pkgs.lixPackageSets.stable.lix;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;
}
