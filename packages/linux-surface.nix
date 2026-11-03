{ nixpkgs, nixos-hardware }:
let
  surfaceCommon = nixos-hardware.nixosModules.microsoft-surface-common;
  mkSurfaceKernelConfig =
    kernelVersion:
    (nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        surfaceCommon
        {
          hardware.microsoft-surface.kernelVersion = kernelVersion;
          boot.kernelPatches = [
            {
              name = "rust-x86-target-spec";
              patch = ../patches/linux-rust-x86-target-spec.patch;
            }
          ];
        }
        ../modules/surface-gpe-sp9-business.nix
      ];
    }).config;
  stableConfig = mkSurfaceKernelConfig "stable";
in
{
  kernelPackages = stableConfig.boot.kernelPackages;

  linux-surface-stable = stableConfig.boot.kernelPackages.kernel;
}
