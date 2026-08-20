{
  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    kernel-nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex-desktop-linux = {
      url = "github:ilysenko/codex-desktop-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "kernel-nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, kernel-nixpkgs, home-manager, plasma-manager, zen-browser, codex-desktop-linux, vscode-server, nixos-hardware, nixos-wsl, nix-darwin, ... }:
    let
      surfaceKernel = import ./packages/linux-surface.nix {
        nixpkgs = kernel-nixpkgs;
        inherit nixos-hardware;
      };
    in
    {
      devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" ] (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              deadnix
              statix
            ];
          };
        });

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
            ({ lib, ... }: {
              boot.kernelPackages = lib.mkForce surfaceKernel.kernelPackages;
            })
          ];
          specialArgs = { inherit plasma-manager zen-browser codex-desktop-linux; };
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
      darwinConfigurations = {
        m2air = nix-darwin.lib.darwinSystem {
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin-common.nix
            ./hosts/m2air/configuration.nix
          ];
          specialArgs = { inherit self; };
        };
      };

      # CI でビルドさせるパッケージを明示的に公開
      packages.x86_64-linux = {
        inherit (surfaceKernel) linux-surface-lts;
      };
    };
}
