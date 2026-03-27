{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "sp9-v7";

  services.xserver.xkb = {
    layout = "jp";
    variant = "";
  };

  system.stateVersion = "25.11";
}
