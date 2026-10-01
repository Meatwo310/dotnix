{ pkgs, ... }:

{
  imports = [
    ../../home/common.nix
    ../../home/modules/input-method.nix
    ../../home/modules/plasma.nix
  ];

  programs.plasma.input = {
    keyboard.layouts = [
      { layout = "jp"; }
    ];
    touchpads = [
      {
        name = "Microsoft Surface 045E:09AF Touchpad";
        vendorId = "045e";
        productId = "09af";
        disableWhileTyping = false;
        naturalScroll = true;
        rightClickMethod = "twoFingers";
      }
    ];
  };

  xdg.configFile."fcitx5/profile" = {
    force = true;
    source = (pkgs.formats.ini { }).generate "fcitx5-profile" {
      "Groups/0" = {
        Name = "Default";
        "Default Layout" = "jp";
        DefaultIM = "mozc";
      };
      "Groups/0/Items/0" = {
        Name = "mozc";
        Layout = "";
      };
      GroupOrder."0" = "Default";
    };
  };

  home.stateVersion = "25.11";
}
