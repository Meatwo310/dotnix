{ lib
, stdenvNoCC
, fetchurl
, makeWrapper
}:

stdenvNoCC.mkDerivation rec {
  pname = "codexbar-cli";
  version = "0.53.0";

  src = fetchurl {
    url = "https://github.com/steipete/CodexBar/releases/download/v${version}/CodexBarCLI-v${version}-linux-musl-x86_64.tar.gz";
    hash = "sha256-PGIIZv6QCk4t+hPGgMDK70nQxC4GBTpR3x/9QpMI/dA=";
  };

  sourceRoot = ".";

  dontBuild = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 CodexBarCLI "$out/libexec/codexbar/CodexBarCLI"
    install -Dm444 VERSION "$out/libexec/codexbar/VERSION"
    makeWrapper "$out/libexec/codexbar/CodexBarCLI" "$out/bin/codexbar"

    runHook postInstall
  '';

  meta = {
    description = "CLI for showing AI coding-provider usage";
    homepage = "https://github.com/steipete/CodexBar";
    license = lib.licenses.mit;
    mainProgram = "codexbar";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
  };
}
