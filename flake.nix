{
  description = "Tales' nix and nixos stuff :D";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sundial = {
      url = "github:tcione/sundial";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    forest = {
      url = "github:tcione/forest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ...}@inputs:
  let
    system = "x86_64-linux";
  in {
    darwinConfigurations = {
      MAC2022HJ49 = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/MAC2022HJ49/default.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lapis = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
                ./hosts/MAC2022HJ49/home.nix
              ];
            };
          }
        ];
      };
    };

    nixosConfigurations.sleepy-turtle = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs.overlays = [
            (
              final: prev: {
               forest = inputs.forest.packages.${system}.default;
             }
            )
          ];
        }
        ./hosts/sleepy-turtle/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tortoise.imports = [
            inputs.sops-nix.homeManagerModules.sops
            inputs.sundial.homeManagerModules.${system}.default
            inputs.forest.homeManagerModules.${system}.default
            ./hosts/sleepy-turtle/home.nix
          ];
        }
      ];
    };
  };
}
