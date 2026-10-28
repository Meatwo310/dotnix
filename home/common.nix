{ ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/ssh-keys.nix
  ];

  programs.nix-your-shell.enable = true;
}
