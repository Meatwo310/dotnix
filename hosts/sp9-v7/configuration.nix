{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "sp9-v7";
  system.stateVersion = "25.11";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  console.keyMap = "jp106";

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

    xserver.xkb = {
      layout = "jp";
      variant = "";
    };
  };
}
