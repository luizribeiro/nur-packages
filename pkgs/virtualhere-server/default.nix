{ stdenv, pkgs, lib, ... }:

stdenv.mkDerivation {
  name = "virtualhere-server";

  meta = with lib; {
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
        sha256 = "sha256-Fss0yQBkoWDiN2EOqZZs221q+44Uc5f/pWD3uPRMHL8=";
      };
      aarch64-linux = {
        url = "https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarm64";
        sha256 = "sha256-6cETFeHyI4p4ZHS8cVX7GMKf51HTZez+v3LAr+ReB7o=";
      };
    });

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/virtualhere-server
    chmod +x $out/bin/virtualhere-server
  '';
}
