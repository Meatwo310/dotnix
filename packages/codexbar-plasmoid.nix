{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "codexbar-plasmoid";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "psimaker";
    repo = "codexbar-plasmoid";
    rev = "v0.3.1";
    hash = "sha256-2jZX2CrSgdTAE6ZEKsvvVCVKxMRQjK4DkpCpJWh30ZE=";
  };

  patches = [
    ./codexbar-plasmoid-hide-account-email.patch
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    plasmoidDir="$out/share/plasma/plasmoids/com.github.psimaker.codexbar"
    mkdir -p "$plasmoidDir"
    cp -r contents metadata.json "$plasmoidDir/"

    runHook postInstall
  '';

  meta = {
    description = "CodexBar usage widget for KDE Plasma 6";
    homepage = "https://github.com/psimaker/codexbar-plasmoid";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
