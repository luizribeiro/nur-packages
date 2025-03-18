{ stdenv, pkgs, ... }:

stdenv.mkDerivation {
  name = "virtualhere-server";

  meta = {
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };

  src =
    let
      inherit (stdenv.hostPlatform) system;
      selectSystem = attrs: attrs.${system} or (throw "Unsupported system: ${system}");
    in
    pkgs.fetchurl (selectSystem {
      x86_64-linux = {
        url = "https://www.virtualhere.com/sites/default/files/usbserver/vhusbdx86_64";
        sha256 = "sha256-bZRzVATbJfV5VCC9LWCA97sOgYcPD9bUMZsSWiKoKKA=";
      };
      aarch64-linux = {
        url = "https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm64";
        sha256 = "sha256-WZP8zld6ESvqQYdxv4z56i5GoA1pQLGmwkXATcU8NH8=";
      };
    });

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/virtualhere-server
    chmod +x $out/bin/virtualhere-server
  '';
}
