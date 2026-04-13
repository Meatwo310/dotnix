{ pkgs, ... }:

{
  imports = [ ../../home/common.nix ];

  home.username = "moon";
  home.homeDirectory = "/Users/moon";
  home.stateVersion = "24.11";

  # On macOS, nh is configured via home-manager (no nix-darwin system module)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/Users/moon/dotnix";
  };
}
