{ nixpkgs, nixos-hardware }:
let
  surfaceCommon = nixos-hardware.nixosModules.microsoft-surface-common;
  mkSurfaceKernelConfig = kernelVersion:
    (nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        surfaceCommon
        { hardware.microsoft-surface.kernelVersion = kernelVersion; }
        ../modules/surface-gpe-sp9-business.nix
      ];
    }).config;
  ltsConfig = mkSurfaceKernelConfig "longterm";
in
{
  kernelPackages = ltsConfig.boot.kernelPackages;

  # longterm (LTS) カーネル
  linux-surface-lts = ltsConfig.boot.kernelPackages.kernel;

  # # stable カーネル
  # linux-surface-stable = (mkSurfaceKernelConfig "stable").boot.kernelPackages.kernel;
}
