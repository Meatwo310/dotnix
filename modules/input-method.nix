{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        kdePackages.fcitx5-qt
      ];
      waylandFrontend = true;
    };
  };
}
