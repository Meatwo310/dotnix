{ config, pkgs, ... }:

{
  services = {
    xserver.enable = true;
    displayManager.ly.enable = true;
    desktopManager.plasma6.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
  };

  security.rtkit.enable = true;

  programs = {
    firefox.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kate
  ];
}
