{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, vscode-server, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {
      sp9-v7 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          vscode-server.nixosModules.default
          ./modules/common.nix
          ./modules/desktop.nix
          nixos-hardware.nixosModules.microsoft-surface-pro-9
          ./hosts/sp9-v7/configuration.nix
        ];
      };
    };
  };
}

