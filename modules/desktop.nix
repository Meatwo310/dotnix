{ lib, pkgs, plasma-manager, zen-browser, codex-desktop-linux, ... }:

let
  zen = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
  zen-alt = pkgs.writeShellScriptBin "zen-alt" ''
    exec ${lib.getExe zen} \
      -no-remote \
      -profile "$HOME/.config/zen/zen-alt" \
      "$@"
  '';
in

{
  imports = [
    codex-desktop-linux.nixosModules.default
  ];

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

  networking.firewall = {
    allowedTCPPorts = [
      53317 # LocalSend のファイル転送用
    ];
    allowedUDPPorts = [
      53317 # LocalSend の端末検出用
    ];
  };

  programs = {
    codexDesktopLinux = {
      enable = true;
      cliPackage = pkgs.codex;
    };
    firefox.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    discover
    elisa
    khelpcenter
  ];

  environment.systemPackages = with pkgs; [
    (callPackage ../packages/codexbar-cli.nix { })
    (callPackage ../packages/codexbar-plasmoid.nix { })
    (callPackage ../packages/kvitals.nix { })
    discord
    gparted
    haruna
    krita
    kdePackages.filelight
    kdePackages.kate
    kdePackages.partitionmanager
    kdePackages.yakuake
    localsend
    prismlauncher
    zen
    zen-alt
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
      antialias = true;

      hinting = {
        enable = true;
        style = "slight";
      };

      subpixel = {
        rgba = "vbgr";
        lcdfilter = "default";
      };

      includeUserConf = false;

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
