{ pkgs, ... }:

{
  imports = [ ../../home/common.nix ];

  home.username = "moon";
  home.homeDirectory = "/Users/moon";
  home.stateVersion = "24.11";
}
