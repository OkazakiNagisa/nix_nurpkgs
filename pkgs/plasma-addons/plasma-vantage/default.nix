{
  lib,
  stdenvNoCC,
  fetchFromGitLab,
  kdePackages,
  breakpointHook
}:

stdenvNoCC.mkDerivation rec {
  meta = with lib; {
    description = "Plasma widget to control Lenovo Legion/Ideapad laptop features (PlasmaVantage)";
    homepage = "https://gitlab.com/Scias/plasmavantage";
    license = licenses.mpl20;
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    platforms = platforms.linux;
    mainProgram = null;
  };

  pname = "plasma-vantage";
  version = "0.29";

  src = fetchFromGitLab {
    owner = "Scias";
    repo = "plasmavantage";
    rev = "${version}";
    hash = "sha256-ix26p2Oo64WFI5AF8D+HdlfwVz2wuJ+NfA5th489jPU=";
  };

  dontBuild = true;

  nativeBuildInputs = [
    kdePackages.kpackage
    breakpointHook
  ];

  installPhase = ''
    runHook preInstall

    kpackagetool6 --type=Plasma/Applet \
                  --install=$src/package \
                  --packageroot=$out/share/plasma/plasmoids

    runHook postInstall
  '';
}