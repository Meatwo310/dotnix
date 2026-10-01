{ config, ... }:

{
  programs.git = {
    enable = true;
    package = null;
    settings = {
      user = {
        name = "Meatwo310";
        email = "git@meatwo310.net";
      };
      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
    };
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519_git";
      format = "ssh";
      signByDefault = true;
    };
  };
}
