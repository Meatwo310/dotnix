{ pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = lib.mkMerge [
      # p10k instant prompt must be sourced before everything else in .zshrc
      (lib.mkBefore "source ${./p10k.zsh}")

      # Source p10k theme after oh-my-zsh
      "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"

      ''
        n#() {
          if [[ -z "$1" ]]; then
            print -u2 -- 'Usage: n# <package> [args...]'
            return 2
          fi

          local package="$1"
          shift
          nix run "nixpkgs#$package" -- "$@"
        }
      ''
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "extract"
        "git"
      ];
    };
  };
}
