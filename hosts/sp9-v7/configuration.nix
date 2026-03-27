{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sp9-v7";

  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  console.keyMap = "jp106";

  system.stateVersion = "25.11";

  # boot.kernelParams = [ "i915.enable_psr=1" ];
}
