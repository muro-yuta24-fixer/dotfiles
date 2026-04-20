{ pkgs, nixpkgs-unstable, ... }:

let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = [
    unstable.ollama-cpu
  ];
}
