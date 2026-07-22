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

  networking.hostName = "ymuro-macbook";
  networking.computerName = "ymuro-macbook";

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
      "herdr"
    ];
    casks = [ ];
    masApps = { };
  };

  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    dock.autohide = true;
  };
}
