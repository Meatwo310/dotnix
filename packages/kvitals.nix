{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "kvitals";
  version = "2.13.0";

  src = fetchFromGitHub {
    owner = "yassine20011";
    repo = "kvitals";
    rev = "v2.13.0";
    hash = "sha256-8wUKeZclCqmZrwlNJQBW/kSboSKC73d5DBRRviSsS7E=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    plasmoidDir="$out/share/plasma/plasmoids/org.kde.plasma.kvitals"
    mkdir -p "$plasmoidDir"
    cp -r contents metadata.json "$plasmoidDir/"

    runHook postInstall
  '';

  meta = {
    description = "System vitals widget for KDE Plasma 6";
    homepage = "https://github.com/yassine20011/kvitals";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.linux;
  };
}
