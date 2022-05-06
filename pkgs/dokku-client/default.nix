{ stdenv, pkgs, uptix, ... }:

let
  release = uptix.githubRelease {
    owner = "dokku";
    repo = "dokku";
  };
in
stdenv.mkDerivation {
  pname = "dokku-client";
  version = uptix.version release;
  src = pkgs.fetchFromGitHub release;
  installPhase = ''
    mkdir -p $out/bin
    cp contrib/dokku_client.sh $out/bin/dokku
  '';
}
