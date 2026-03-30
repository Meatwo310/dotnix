{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { nixpkgs, home-manager, vscode-server, nixos-hardware, nixos-wsl, ... }: {
    nixosConfigurations = {
      sp9-v7 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.microsoft-surface-pro-9
          home-manager.nixosModules.home-manager
          vscode-server.nixosModules.default
          ./modules/common.nix
          ./modules/desktop.nix
          ./modules/zsh/zsh.nix
          ./hosts/sp9-v7/configuration.nix
        ];
      };
      gaming-wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          ./modules/common.nix
          ./modules/zsh/zsh.nix
          ./hosts/gaming-wsl/configuration.nix
        ];
      };
    };

    # CI でビルドさせるパッケージを明示的に公開
    packages.x86_64-linux =
      (import ./packages/linux-surface.nix { inherit nixpkgs nixos-hardware; });
  };
}
