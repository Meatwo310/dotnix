{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "codexbar-plasmoid";
  version = "0.2.0-unstable-2026-07-23";

  src = fetchFromGitHub {
    owner = "psimaker";
    repo = "codexbar-plasmoid";
    rev = "09e6bc690cae62c5e13fc95695d27b55f95b1f81";
    hash = "sha256-QCKwRG7WTC3RCvWnFUVUcjGhXIyQq9KupJdHdouDSSY=";
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
