{ pkgs, ... }:

{
  # Enable zsh system-wide so it appears in /etc/shells
  programs.zsh.enable = true;

  # Set zsh as the default login shell for all users
  users.defaultUserShell = pkgs.zsh;
}
