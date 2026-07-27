{ config, lib, pkgs, plasma-manager, zen-browser, ... }:

{
  services = {
    xserver.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        clear_password = true;
        default_input = "password";
        show_tty = true;
        tty = lib.mkForce 2;
      };
    };
    desktopManager.plasma6.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  security = {
    rtkit.enable = true;
    pam.services.ly.kwallet.enable = true;
  };

  programs = {
    firefox.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    khelpcenter
  ];

  environment.systemPackages = with pkgs; [
    gparted
    krita
    kdePackages.filelight
    kdePackages.kate
    kdePackages.partitionmanager
    kdePackages.yakuake
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home-manager.sharedModules = [
    plasma-manager.homeModules.plasma-manager
  ];
}
