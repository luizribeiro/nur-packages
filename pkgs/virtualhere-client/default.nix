{ stdenv, pkgs, ... }:

stdenv.mkDerivation {
  name = "virtualhere-client";

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
        url = "https://www.virtualhere.com/sites/default/files/usbclient/vhclientx86_64";
        sha256 = "sha256-WSq/hNqTHs2lSbl/lDs/5/G7PS+GuXdQYvXLr4j8VyA=";
      };
      aarch64-linux = {
        url = "https://www.virtualhere.com/sites/default/files/usbclient/vhclientarm64";
        sha256 = "sha256-WV79VdTPdB/Rhgw7WoMrBcnNa6VXZ76VPDa0XOfsDFs=";
      };
    });

  unpackPhase = ":";

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/virtualhere
    chmod +x $out/bin/virtualhere
  '';
}
