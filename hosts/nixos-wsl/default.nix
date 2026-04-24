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

  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };

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
