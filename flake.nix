{
  description = "Tales' nix and nixos stuff :D";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, ...}@inputs: {
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
