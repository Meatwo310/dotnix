{ ... }:

let
  uiFont = {
    family = "Inter";
    pointSize = 10;
  };
in
{
  fonts.fontconfig.enable = false;

  programs.plasma = {
    enable = true;

    fonts = {
      general = uiFont;
      fixedWidth = {
        family = "JetBrainsMono Nerd Font Mono";
        pointSize = 10;
      };
      small = uiFont // {
        pointSize = 8;
      };
      toolbar = uiFont;
      menu = uiFont;
      windowTitle = uiFont;
    };

    shortcuts = {
      kwin."Window Close" = [ "Meta+Q" "Alt+F4" ];
    };
  };
}
