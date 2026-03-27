{ config, pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [ "https://meatwo310-dotnix.cachix.org" ];
    trusted-public-keys = [ "meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k=" ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Tokyo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  networking.networkmanager.enable = true;

  services = {
    openssh.enable = true;
    tailscale.enable = true;
    vscode-server.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/moon/dotnix";
  };

  users.users.moon = {
    isNormalUser = true;
    description = "Moon";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    nil          # Nix Language Server
    nixpkgs-fmt  # Nix formatter
  ];
}
