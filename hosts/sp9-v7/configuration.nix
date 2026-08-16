{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/input-method.nix
  ];

  networking.hostName = "sp9-v7";

  time.hardwareClockInLocalTime = true;

  home-manager.users.moon = import ./home.nix;
  system.stateVersion = "25.11";

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      windows."11" = {
        title = "Windows 11";
        efiDeviceHandle = "FS0";
      };
    };
    efi.canTouchEfiVariables = true;
  };

  console.keyMap = "jp106";

  networking = {
    networkmanager.enable = true;
    firewall.trustedInterfaces = [ "tailscale0" ];
  };

  environment.systemPackages = with pkgs; [
    nil # Nix Language Server
    nixpkgs-fmt # Nix formatter
  ];

  users.users.moon.extraGroups = [ "networkmanager" ];

  services = {
    openssh.enable = true;
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    vscode-server.enable = true;

    xserver.xkb = {
      layout = "jp";
      variant = "";
    };
  };

  # サスペンド後電源ボタンが動作しない問題への回避策 (linux-surface/linux-surface#1910)
  boot.initrd.kernelModules = [
    "pinctrl_tigerlake"
  ];
}
