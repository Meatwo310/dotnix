{
  nix-homebrew = {
    enable = true;
    # Allow migrating an existing Homebrew installation to nix-homebrew management.
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };
}
