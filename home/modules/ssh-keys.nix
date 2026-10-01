let
  gitKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIppAIuGG8Wi5e8LLMHe+f6IKBfzI2Ex6qSvu6lMoSqI git@meatwo310.net";
in
{
  # Place the matching private keys manually at the same paths without .pub.
  home.file = {
    ".ssh/id_ed25519.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJP6EExJi+6s6AV9Ru06hDYuqlbr2SIA+aroPp17vx+P key@meatwo310.net
    '';
    ".ssh/id_ed25519_git.pub".text = gitKey + "\n";
    ".ssh/allowed_signers".text = ''
      git@meatwo310.net ${gitKey}
    '';
    ".ssh/id_ed25519_github.pub".text = ''
      ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILBcPsQCUOMOm9EtLr92S04+wgHMOGZsYfBBWli/gUaP GitHub Authentication
    '';
  };
}
