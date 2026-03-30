{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "moon";

  system.stateVersion = "25.11";

  networking.hostName = "gaming-wsl";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://nix-community.cachix.org"      # priority 41
      "https://meatwo310-dotnix.cachix.org"   # priority 42
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/moon/dotnix";
  };

  programs = {
    vim.enable = true;
    git.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];
}
