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

    input.touchpads = [
      {
        name = "Microsoft Surface 045E:09AF Touchpad";
        vendorId = "045e";
        productId = "09af";
        disableWhileTyping = false;
        naturalScroll = true;
        rightClickMethod = "twoFingers";
      }
    ];

    powerdevil = {
      AC = {
        powerButtonAction = "lockScreen";
        powerProfile = "performance";
      };
      battery = {
        powerButtonAction = "lockScreen";
        powerProfile = "balanced";
      };
      lowBattery = {
        powerButtonAction = "lockScreen";
        powerProfile = "powerSaving";
      };
      batteryLevels.criticalAction = "shutDown";
    };

    # plasma-manager の高水準オプションは true と輝度値の組み合わせしか表現できない
    configFile.powerdevilrc."LowBattery/Display".UseProfileSpecificDisplayBrightness = false;

    shortcuts = {
      kwin = {
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Switch to Desktop 8" = "Meta+8";
        "Switch to Desktop 9" = "Meta+9";
        "Window Close" = [ "Meta+Q" "Alt+F4" ];
      };

      plasmashell = {
        "activate task manager entry 1" = [ ];
        "activate task manager entry 2" = [ ];
        "activate task manager entry 3" = [ ];
        "activate task manager entry 4" = [ ];
        "activate task manager entry 5" = [ ];
        "activate task manager entry 6" = [ ];
        "activate task manager entry 7" = [ ];
        "activate task manager entry 8" = [ ];
        "activate task manager entry 9" = [ ];
        "manage activities" = [ ];
        "next activity" = "Meta+A";
        "previous activity" = "Meta+Shift+A";
      };

      yakuake."toggle-window-state" = "Zenkaku Hankaku";
    };
  };
}
