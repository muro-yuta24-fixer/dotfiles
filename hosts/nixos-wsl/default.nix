{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./ffmpeg.nix
  ];

  boot.kernel.sysctl = {
    "vm.swappiness" = 0;
  };

  networking.hostName = "nixos-wsl";

  wsl = {
    enable = true;
    defaultUser = "nixos";
    interop = {
      includePath = false;
    };
  };

  environment.systemPackages = with pkgs; [
    lsof
    nettools

    docker-compose
    docker-buildx
    directx-headers

    btop
  ];

  virtualisation.docker = {
    enable = true;
  };

  users.users.nixos.extraGroups = [ "docker" ];
}
