{ config, lib, pkgs, self, ... }:

{
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/Users/moon/dotnix";
  };

  home-manager.users.moon = import ./home.nix;
}
