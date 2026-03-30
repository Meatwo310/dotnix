{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    nil          # Nix Language Server
    nixpkgs-fmt  # Nix formatter
  ];

  users.users.moon.extraGroups = [ "networkmanager" ];

  services = {
    openssh.enable = true;
    tailscale.enable = true;
    vscode-server.enable = true;
  };
}
