{ pkgs, ... }:

{
  imports = [ ../../home/common.nix ];

  home.stateVersion = "24.11";

  programs.zsh.profileExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    export PATH="$PATH:/Users/moon/Library/Application Support/JetBrains/Toolbox/scripts"
  '';

  # On macOS, nh is configured via home-manager (no nix-darwin system module)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/Users/moon/dotnix";
  };

  programs.bun = {
    enable = true;
  };
}
