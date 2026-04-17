{ pkgs, lib, ... }:

{
  programs.plasma = {
    enable = true;

    shortcuts = {
      kwin."Window Close" = [ "Meta+Q" "Alt+F4" ];
    };
  };
}

