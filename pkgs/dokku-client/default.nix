{ stdenv, pkgs, ... }:

stdenv.mkDerivation {
  name = "dokku-client";

  src = pkgs.fetchFromGitHub {
    owner = "dokku";
    repo = "dokku";
    rev = "e0c2e7846a551c21fab7595737ae3b988d59578e";
    sha256 = "UQ/CSAlAOMn2tGOlkTQFLl97xZdqDc3XBICF1Az91sY=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp contrib/dokku_client.sh $out/bin/dokku
  '';
}
