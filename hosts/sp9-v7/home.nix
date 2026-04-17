{ pkgs, ... }:

{
  imports = [
    ../../home/common.nix
    ../../home/modules/plasma.nix
  ];

  home.stateVersion = "25.11";
}
