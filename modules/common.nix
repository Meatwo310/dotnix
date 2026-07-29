{ pkgs, ... }:

{
  imports = [ ./base.nix ];

  i18n.defaultLocale = "ja_JP.UTF-8";
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

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/moon/dotnix";
  };

  users.users.moon = {
    isNormalUser = true;
    description = "Moon";
    extraGroups = [ "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

  programs = {
    vim = {
      enable = true;
      defaultEditor = true;
    };
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    codex
    gh
  ];
}
