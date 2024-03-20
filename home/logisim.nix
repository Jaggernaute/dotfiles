{ pkgs, ... }:
pkgs.stdenv.mkDerivation {
  pname = "logisim-evolution";
  version = "2023";

  src = pkgs.fetchurl {
    url = "http://www.irisa.fr/cosi/HOMEPAGE/Derrien/logisim/logisim-evolution.jar";
    sha256 = "sha256-24uXyTXhxxA1uwc787I+OJn+ZmqMgNIL9RE3zoRrWww=";
  };

  dontUnpack = true;

  nativeBuildInputs = with pkgs; [ makeWrapper unzip zip ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    makeWrapper ${pkgs.jre8}/bin/java $out/bin/logisim-evolution \
      --add-flags "-jar $src"                               \
      --set _JAVA_AWT_WM_NONREPARENTING 1

    runHook postInstall
  '';

  # NOTE: related issue
  # https://wiki.archlinux.org/title/java#Gray_window,_applications_not_resizing_with_WM,_menus_immediately_closing
}

