{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./ffmpeg.nix
    ./ollama.nix
  ];

  networking.hostName = "nixos-wsl";

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  environment.systemPackages = with pkgs; [
    lsof
    nettools

    docker-compose
    docker-buildx
    directx-headers
  ];

  virtualisation.docker = {
    enable = true;
  };

  users.users.nixos.extraGroups = [ "docker" ];
}
