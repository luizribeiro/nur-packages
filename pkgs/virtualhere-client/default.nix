{ stdenv, pkgs, lib, ... }:

stdenv.mkDerivation {
  name = "virtualhere-client";

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
        url = "https://www.virtualhere.com/sites/default/files/usbclient/vhclientx86_64";
        sha256 = "sha256-VBpyhIlHTYJTI5A/H4b1XHNd7RgS84RFYJG8oWRqmak=";
      };
      aarch64-linux = {
        url = "https://www.virtualhere.com/sites/default/files/usbclient/vhclientarm64";
        sha256 = "sha256-1p7lxAhvI954xC67pXaJ9vEEwhxg0eYKrVD6PkqIGBg=";
      };
    });

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/virtualhere
    chmod +x $out/bin/virtualhere
  '';
}
