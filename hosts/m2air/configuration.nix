{ self, ... }:

{
  system = {
    configurationRevision = self.rev or self.dirtyRev or null;
    stateVersion = 6;
    primaryUser = "moon";
  };
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix-homebrew.user = "moon";
  homebrew.casks = [
    "chatgpt"
    "codex"
    "codexbar"
    "iterm2"
  ];

  # Tell nix-darwin (and home-manager) where the user lives on macOS
  users.users.moon = {
    home = "/Users/moon";
  };

  home-manager.users.moon = import ./home.nix;
}
