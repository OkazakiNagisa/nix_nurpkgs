{ pkgs, stdenv }:
stdenv.mkDerivation rec {
  pname = "flatseal";
  version = "2.4.0";

  src = ./Flatseal;

  nativeBuildInputs = with pkgs; [
    meson
    ninja
    pkg-config
    wrapGAppsHook4
    desktop-file-utils
    appstream-glib
    gettext
    glib # for glib-compile-schemas
  ];

  buildInputs = with pkgs; [
    gjs
    glib
    gtk4
    libadwaita
    webkitgtk_6_0
    appstream
  ];

  mesonFlags = [
    "--buildtype=release"
  ];

  meta = with pkgs.lib; {
    broken = true;
    description = "Graphical utility to review and modify Flatpak permissions";
    longDescription = ''
      Flatseal is a graphical utility to review and modify permissions 
      from your Flatpak applications. Simply launch Flatseal, select 
      an application and modify its permissions. 
    '';
    homepage = "https://github.com/tchx84/Flatseal";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
    mainProgram = "com.github.tchx84.Flatseal";
  };
}