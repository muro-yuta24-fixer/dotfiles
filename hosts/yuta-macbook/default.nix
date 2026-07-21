{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./database.nix
    ./ffmpeg.nix
  ];

  networking.hostName = "yuta-macbook";
  networking.computerName = "yuta-macbook";

  nix-homebrew = {
    enable = true;
    enableRosetta = false;
    user = "yuta";
    autoMigrate = true;
    mutableTaps = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    brews = [
      "btop"
    ];
    casks = [ ];
    masApps = { };
  };

  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    dock.autohide = true;
  };
}
