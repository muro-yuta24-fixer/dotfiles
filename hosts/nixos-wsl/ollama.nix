{ pkgs, nixpkgs-unstable, ... }:

let
  unstable = import nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  services.ollama = {
    enable = true;
    package = unstable.ollama-cpu;
    openFirewall = true;
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "0";
    };
  };
}
