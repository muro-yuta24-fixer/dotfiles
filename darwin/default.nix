{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [ ../system/common.nix ];

  system.stateVersion = 6;

  system.primaryUser = "yuta";

  nix.enable = true;

  programs.zsh.enable = true;

  users.users.yuta = {
    name = "yuta";
    home = "/Users/yuta";
    shell = pkgs.zsh;
  };

  nixpkgs.overlays = [
    (_: prev: {
      direnv = prev.direnv.overrideAttrs (_: { doCheck = false; });
    })
  ];

  environment.systemPackages = with pkgs; [
    wget
    curl
    vim
  ];

  fonts.packages = with pkgs; [
    plemoljp-nf
  ];
}
