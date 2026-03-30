{ config, lib, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # TODO: home-managerを使わない方法を探す
  home-manager.sharedModules = [{
    programs.zsh = {
      enable = true;
      initContent = lib.mkBefore "source ${./.p10k.zsh}";
      plugins = [
        {                                                                                   
          name = "powerlevel10k";                                                           
          src = pkgs.zsh-powerlevel10k;                                                     
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";                         
        }
      ];
    };
  }];
}
