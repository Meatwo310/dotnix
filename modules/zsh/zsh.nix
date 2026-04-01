{ config, lib, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellInit = lib.mkBefore "source ${./.p10k.zsh}";
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "extract"
      ];
    };
  };

  system.userActivationScripts.zshrc = "touch .zshrc";
}
