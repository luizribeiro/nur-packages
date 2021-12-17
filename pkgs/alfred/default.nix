{ stdenv, lib, fetchurl, undmg }:

with lib;

stdenv.mkDerivation rec {
  pname = "alfred";
  version = "4.6.1";

  # The disk image contains the .app and a symlink to /Applications.
  sourceRoot = "Alfred 4.app";

  src = fetchurl {
    url = "https://cachefly.alfredapp.com/Alfred_4.6.1_1274.dmg";
    sha256 = "sha256-KFGm2gDorYW7AAkxodnb2gDSdALU47fI+9d9iVawCbM=";
  };

  buildInputs = [ undmg ];
  installPhase = ''
    mkdir -p "$out/Applications/Alfred 4.app"
    cp -R . "$out/Applications/Alfred 4.app"
  '';

  meta = with lib; {
    description = "Application launcher and productivity software";
    homepage = "https://www.alfredapp.com/";
    # FIXME: make this unfree again. I couldn't figure it out how to get it
    # to install for some reason
    #license = licenses.unfree;
    platforms = platforms.darwin;
  };
}
