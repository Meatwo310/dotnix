{ pkgs, ... }:

{
  imports = [ ./base.nix ];

  environment.variables.HOMEBREW_NO_ENV_HINTS = "1";

  environment.systemPackages = with pkgs; [
    git
  ];
}
