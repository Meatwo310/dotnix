# Repository Guidelines

## Project Structure & Module Organization

This repository is a multi-host Nix flake for NixOS, NixOS-WSL, and nix-darwin.

- `flake.nix` declares inputs, supported hosts, and exported packages; `flake.lock` pins dependencies.
- `hosts/<hostname>/` contains host-specific system and Home Manager configuration. Current hosts are `sp9-v7`, `gaming-wsl`, and `m2air`.
- `modules/` contains reusable system modules; platform-specific configuration belongs in files such as `desktop.nix` or `darwin-common.nix`.
- `home/` contains shared and host-imported Home Manager modules.
- `packages/` exposes custom derivations, including the Surface kernel package.
- `.github/workflows/` defines flake checks, host builds, Cachix publishing, and action pin verification.

Keep reusable settings in modules and reserve `hosts/` for machine-specific differences.

## Build, Test, and Development Commands

- `nix flake check` evaluates the flake and runs its declared checks. Run this before every pull request.
- `nix build .#nixosConfigurations.sp9-v7.config.system.build.toplevel --no-link` validates a NixOS host without switching.
- `nix build .#darwinConfigurations.m2air.config.system.build.toplevel --no-link` validates the macOS host.
- `nix build .#packages.x86_64-linux.linux-surface-lts --no-link` builds the custom heavy package used in CI.
- `nh os switch` applies the current NixOS host; `nh darwin switch` applies the nix-darwin host. Review changes before switching.
- `nixpkgs-fmt .` formats all Nix files.
- `nix develop` enters the development shell with `statix` and `deadnix`.
- `statix check .` checks Nix files for style and correctness issues.
- `deadnix --fail --exclude hosts/sp9-v7/hardware-configuration.nix -- .` reports unused Nix code while excluding the generated hardware configuration.

## Coding Style & Naming Conventions

Use two-space indentation and the existing `nixpkgs-fmt` style. Prefer small, composable modules and explicit relative imports. Name host directories after `networking.hostName`; use lowercase kebab-case for module and package files. Keep comments focused on non-obvious platform constraints or workarounds. The repository’s VS Code settings use `nil` for language-server diagnostics.

## Testing Guidelines

There is no separate unit-test suite. Tests are evaluation and build based: run `nix flake check`, `statix`, and `deadnix`, then build every affected host or package. A change to shared files under `modules/` or `home/common.nix` should be checked against all relevant configurations. Do not commit generated `result` symlinks.

## Commit & Pull Request Guidelines

History follows Conventional Commits, often with scopes: `feat(desktop): ...`, `fix(plasma): ...`, or `chore: update flake inputs`. Keep commits focused and use an imperative summary. Pull requests should explain the affected hosts, motivation, commands run, and any manual switch verification. Link relevant issues. Ensure Build and Check and Pinact CI pass, and keep GitHub Actions pinned to full commit SHAs.
