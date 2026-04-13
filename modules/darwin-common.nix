{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://nix-community.cachix.org"      # priority 41
      "https://meatwo310-dotnix.cachix.org"   # priority 42
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "meatwo310-dotnix.cachix.org-1:F4Stc7Ivxgl72SHWe8z0pOHAe8Ip7zMFgOK6hdkh26k="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Tokyo";

  # Enable zsh system-wide (adds to /etc/shells)
  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  environment.systemPackages = with pkgs; [
    wget
    git
  ];
}
