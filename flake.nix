{
  description = "My NixOS System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-claude-code = {
      url = "github:ryoppippi/nix-claude-code";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-wsl,
      home-manager,
      catppuccin,
      nix-claude-code,
      nixvim,
      ...
    }:
    {
      nixosConfigurations.nixos-wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager

          ./configuration.nix
          # ./hardware-configuration.nix
          ./ffmpeg.nix
          {
            nixpkgs.overlays = [ nix-claude-code.overlays.default ];

            home-manager.useGlobalPkgs = true;
            home-manager.users.nixos = {
              imports = [
                catppuccin.homeModules.catppuccin
                nixvim.homeModules.nixvim
                ./home.nix
                ./nixvim.nix
              ];
            };
          }
        ];
      };
    };
}
