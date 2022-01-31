{ stdenv, pkgs, ... }:

stdenv.mkDerivation {
  name = "virtualhere-client";

  meta = with lib; {
    platforms = [ "x86_64-linux" ];
  };

  src = pkgs.fetchurl {
    url = "https://www.virtualhere.com/sites/default/files/usbclient/vhclientx86_64";
    sha256 = "sha256-Uk24LEal9PEJM4pEOc4HHj65rudW/HCIuIXc1NWetVk=";
  };

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/virtualhere
    chmod +x $out/bin/virtualhere
  '';
}
