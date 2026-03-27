{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      sp9-v7 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/sp9-v7/configuration.nix
        ];
      };
    };
  };
}

