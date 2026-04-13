{ pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/nvim.nix
  ];
}
