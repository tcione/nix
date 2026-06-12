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
    catppuccin.url = "github:catppuccin/nix";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sundial = {
      url = "github:tcione/sundial";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elephant = {
      url = "github:abenz1267/elephant";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
    llm-agents.url = "github:numtide/llm-agents.nix";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ...}@inputs:
  let
    system = "x86_64-linux";
  in {
    darwinConfigurations = {
      MAC2022HJ49 = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          { nixpkgs.overlays = [ inputs.llm-agents.overlays.default ]; }
          ./hosts/MAC2022HJ49/default.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.lapis = {
              imports = [
                inputs.sops-nix.homeManagerModules.sops
                inputs.nix-index-database.homeModules.nix-index
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
               pi = inputs.llm-agents.packages.${system}.pi;
             }
            )
          ];
        }
        ./hosts/sleepy-turtle/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.tortoise.imports = [
            inputs.walker.homeManagerModules.default
            inputs.sops-nix.homeManagerModules.sops
            inputs.sundial.homeManagerModules.${system}.default
            inputs.nix-index-database.homeModules.nix-index
            inputs.catppuccin.homeModules.catppuccin
            ./hosts/sleepy-turtle/home.nix
          ];
        }
      ];
    };
  };
}
