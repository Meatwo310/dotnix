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
      kwin."Window Close" = [ "Meta+Q" "Alt+F4" ];
    };
  };
}
