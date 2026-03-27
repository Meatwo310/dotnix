{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = { self, nixpkgs, vscode-server, ... }@inputs: {
    nixosConfigurations = {
      sp9-v7 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          vscode-server.nixosModules.default
          ./modules/common.nix
          ./modules/desktop.nix
          ./hosts/sp9-v7/configuration.nix
        ];
      };
    };
  };
}

