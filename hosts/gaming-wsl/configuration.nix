{ config, lib, pkgs, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = "moon";

  system.stateVersion = "25.11";

  networking.hostName = "gaming-wsl";
}
