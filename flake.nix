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

    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      surfaceCommon = nixos-hardware.nixosModules.microsoft-surface-common;
    in {
      # CI でビルドさせるパッケージを明示的に公開
      packages.x86_64-linux = {
        # longterm (LTS) カーネル
        linux-surface-lts =
          (nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              surfaceCommon
              { hardware.microsoft-surface.kernelVersion = "longterm"; }
            ];
          }).config.boot.kernelPackages.kernel;

        # # stable カーネル
        # linux-surface-stable =
        #   (nixpkgs.lib.nixosSystem {
        #     system = "x86_64-linux";
        #     modules = [
        #       surfaceCommon
        #       { hardware.microsoft-surface.kernelVersion = "stable"; }
        #     ];
        #   }).config.boot.kernelPackages.kernel;
      };
    };
  };
}

