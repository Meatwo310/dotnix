{ config, lib, pkgs, self, ... }:

{
  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 6;
  nixpkgs.hostPlatform = "aarch64-darwin";

  home-manager.users.moon = import ./home.nix;
}
