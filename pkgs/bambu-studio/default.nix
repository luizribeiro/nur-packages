{ lib, pkgs, ... }:

let
  name = "bambu-studio";
  src = pkgs.fetchurl {
    url = "https://github.com/bambulab/BambuStudio/releases/download/v01.07.00.65/BambuStudio_fedora_v01.07.00.65-20230713174938.AppImage";
    hash = "sha256-t+ouo9YCwmOBF58uY0mD0l9GCygRc3uD+TP/OVm0GAg=";
  };
  desktopItem = pkgs.makeDesktopItem {
    inherit name;
    exec = name;
    icon = "BambuStudio";
    comment = "Software for Bambu Lab 3D printers";
    desktopName = "Bambu Studio";
    categories = [ "Development" ];
  };
  appimageContents = pkgs.appimageTools.extractType2 { inherit name src; };
in
pkgs.appimageTools.wrapType2 {
  inherit name src;

  extraPkgs = p: (pkgs.appimageTools.defaultFhsEnvArgs.multiPkgs p) ++ (with p; [
    libsoup
    mesa_drivers.osmesa
    webkitgtk
    zstd
  ]);

  extraInstallCommands = ''
    mkdir -p $out/share/pixmaps
    ln -s ${desktopItem}/share/applications $out/share/
    cp ${appimageContents}/usr/share/icons/hicolor/192x192/apps/BambuStudio.png $out/share/pixmaps/BambuStudio.png
  '';

  meta = with lib; {
    homepage = "https://github.com/bambulab/BambuStudio/";
    description = "Software for Bambu Lab 3D printers";
    license = licenses.agpl3;
    platforms = [ "x86_64-linux" ];
  };
}
