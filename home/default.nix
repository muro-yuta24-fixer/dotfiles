{ config, pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./cli.nix
    ./tmux.nix
    ./claude.nix
    ./catppuccin.nix
  ];

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    nodejs

    pnpm
    biome
    uv
    sd
    dust
    ghq

    zstd
    p7zip
    parallel

    awscli2

    nixfmt
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
