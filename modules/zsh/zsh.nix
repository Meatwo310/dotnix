{ pkgs, ... }:

{
  # Enable zsh system-wide so it appears in /etc/shells
  programs.zsh.enable = true;

  # Use zsh as the default shell for users without an explicit shell configured
  users.defaultUserShell = pkgs.zsh;
}
