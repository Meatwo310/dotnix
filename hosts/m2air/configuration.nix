{ config, lib, pkgs, self, ... }:

{
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Tell nix-darwin (and home-manager) where the user lives on macOS
  users.users.moon = {
    home = "/Users/moon";
  };

  home-manager.users.moon = import ./home.nix;
}
