{ lib
, stdenvNoCC
, fetchFromGitHub
}:

stdenvNoCC.mkDerivation {
  pname = "kvitals";
  version = "2.13.1";

  src = fetchFromGitHub {
    owner = "yassine20011";
    repo = "kvitals";
    rev = "v2.13.1";
    hash = "sha256-8Jp2q5Z6FRtG4ZtCz4iYEkEDworFDTIYp2OJikkXVy8=";
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
