{
  config,
  lib,
  pkgs,
  ...
}:

{
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
    brews = [ ];
    casks = [ ];
    masApps = { };
  };

  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    dock.autohide = true;
  };
}
