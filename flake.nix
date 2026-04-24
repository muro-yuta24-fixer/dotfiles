{
  description = "My NixOS System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
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
      nixpkgs-unstable,
      nixos-wsl,
      nix-darwin,
      nix-homebrew,
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
          specialArgs = { inherit nixpkgs-unstable; };
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
                  ./home/wsl.nix
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

      darwinConfigurations = {
        yuta-macbook = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit nixpkgs-unstable; };
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            ./darwin
            ./hosts/yuta-macbook
            {
              nixpkgs.overlays = [ nix-claude-code.overlays.default ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.yuta = {
                imports = homeModules ++ [
                  ./home/darwin.nix
                ];
              };
            }
          ];
        };
      };
    };
}
