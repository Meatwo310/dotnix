{ pkgs, ... }:

let
  iniFormat = pkgs.formats.ini { };
  iniWithGlobalSectionFormat = pkgs.formats.iniWithGlobalSection { };
in
{
  programs.plasma.configFile.kwinrc.Wayland = {
    InputMethod = {
      value = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";
      shellExpand = true;
    };
    VirtualKeyboardMode = 2;
  };

  xdg.configFile = {
    "fcitx5/config" = {
      force = true;
      source = iniFormat.generate "fcitx5-config" {
        Hotkey = {
          TriggerKeys = "";
          EnumerateWithTriggerKeys = "True";
          EnumerateForwardKeys = "";
          EnumerateBackwardKeys = "";
          EnumerateSkipFirst = "False";
          ModifierOnlyKeyTimeout = 250;
        };
        "Hotkey/ActivateKeys"."0" = "Hangul_Hanja";
        "Hotkey/DeactivateKeys"."0" = "Hangul_Romaja";
        "Hotkey/AltTriggerKeys"."0" = "Shift_L";
        "Hotkey/EnumerateGroupForwardKeys"."0" = "Super+space";
        "Hotkey/EnumerateGroupBackwardKeys"."0" = "Shift+Super+space";
        "Hotkey/PrevPage"."0" = "Up";
        "Hotkey/NextPage"."0" = "Down";
        "Hotkey/PrevCandidate"."0" = "Shift+Tab";
        "Hotkey/NextCandidate"."0" = "Tab";
        "Hotkey/TogglePreedit"."0" = "Control+Alt+P";
        Behavior = {
          ActiveByDefault = "False";
          resetStateWhenFocusIn = "No";
          ShareInputState = "No";
          PreeditEnabledByDefault = "True";
          ShowInputMethodInformation = "True";
          showInputMethodInformationWhenFocusIn = "False";
          CompactInputMethodInformation = "True";
          ShowFirstInputMethodInformation = "True";
          DefaultPageSize = 5;
          OverrideXkbOption = "False";
          CustomXkbOption = "";
          EnabledAddons = "";
          DisabledAddons = "";
          PreloadInputMethod = "True";
          AllowInputMethodForPassword = "False";
          ShowPreeditForPassword = "False";
          AutoSavePeriod = 30;
        };
      };
    };

    "fcitx5/conf/mozc.conf" = {
      force = true;
      source = iniWithGlobalSectionFormat.generate "fcitx5-mozc.conf" {
        globalSection = {
          InitialMode = "Direct";
          InputState = "\"Follow Global Configuration\"";
          Vertical = "True";
          ExpandMode = "\"On Focus\"";
          PreeditCursorPositionAtBeginning = "False";
          ExpandKey = "Control+Alt+H";
        };
      };
    };

    "fcitx5/conf/notifications.conf" = {
      force = true;
      source = iniWithGlobalSectionFormat.generate "fcitx5-notifications.conf" {
        globalSection.HiddenNotifications = "";
      };
    };
  };
}
