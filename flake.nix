{
  description = "My NixOS System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-claude-code = {
      url = "github:ryoppippi/nix-claude-code";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
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
    let
      homeModules = [
        catppuccin.homeModules.catppuccin
        nixvim.homeModules.nixvim
        ./home
        ./nixvim
      ];
    in
    {
      nixosConfigurations = {
        nixos-wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            ./system
            ./hosts/nixos-wsl
            {
              nixpkgs.overlays = [ nix-claude-code.overlays.default ];

              home-manager.useGlobalPkgs = true;
              home-manager.users.nixos = {
                imports = homeModules ++ [
                  ./home/desktop.nix
                ];
              };
            }
          ];
        };

        nix-hyperv = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./system
            ./hosts/nix-hyperv
            {
              nixpkgs.overlays = [ nix-claude-code.overlays.default ];

              home-manager.useGlobalPkgs = true;
              home-manager.users.nixos = {
                imports = homeModules;
              };
            }
          ];
        };
      };
    };
}
