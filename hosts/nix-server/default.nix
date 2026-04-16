{
  config,
  lib,
  pkgs,
  ...
}:

{
  # VMにデプロイする際は hardware-configuration.nix を生成して追加する
  # nixos-generate-config で生成可能
  # imports = [
  #   ./hardware-configuration.nix
  # ];

  networking.hostName = "nix-server";

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
