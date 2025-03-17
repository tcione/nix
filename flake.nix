{
  description = "Tales' nix and nixos stuff :D";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
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
        ./hosts/sleepy-turtle/configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tortoise.imports = [ ./hosts/sleepy-turtle/home.nix ];
        }
      ];
    };
  };
}
