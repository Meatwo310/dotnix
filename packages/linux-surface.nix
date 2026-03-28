{ nixpkgs, nixos-hardware }:
let
  surfaceCommon = nixos-hardware.nixosModules.microsoft-surface-common;
  mkSurfaceKernel = kernelVersion:
    (nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        surfaceCommon
        { hardware.microsoft-surface.kernelVersion = kernelVersion; }
      ];
    }).config.boot.kernelPackages.kernel;
in {
  # longterm (LTS) カーネル
  linux-surface-lts = mkSurfaceKernel "longterm";

  # # stable カーネル
  # linux-surface-stable = mkSurfaceKernel "stable";
}
