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
    elisa
    khelpcenter
  ];

  environment.systemPackages = with pkgs; [
    gparted
    haruna
    krita
    kdePackages.filelight
    kdePackages.kate
    kdePackages.partitionmanager
    kdePackages.yakuake
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  fonts = {
    packages = with pkgs; [
      inter
      (google-fonts.override {
        fonts = [ "Murecho" ];
      })
      nerd-fonts.jetbrains-mono
      noto-fonts-cjk-sans
      udev-gothic
      udev-gothic-nf
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = [
          "Inter"
          "Murecho"
          "Noto Sans CJK JP"
        ];
        monospace = [
          "JetBrainsMono Nerd Font Mono"
          "UDEV Gothic NFLG"
        ];
      };

      aliases.Inter.accept = [
        "Murecho"
        "Noto Sans CJK JP"
      ];
    };
  };

  home-manager.sharedModules = [
    plasma-manager.homeModules.plasma-manager
  ];
}
