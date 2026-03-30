{ config, pkgs, ... }:

{
  imports = [
    ./common-base.nix
  ];

  networking.networkmanager.enable = true;

  users.users.moon.extraGroups = [ "networkmanager" ];

  services = {
    openssh.enable = true;
    tailscale.enable = true;
    vscode-server.enable = true;
  };
}
