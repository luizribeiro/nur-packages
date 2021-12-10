{ stdenv, pkgs, ... }:

stdenv.mkDerivation {
  name = "ps5-wake";

  src = pkgs.fetchFromGitHub {
    owner = "iharosi";
    repo = "ps5-wake";
    rev = "7699c937c834e49a87d72870e212b7999bffd8b6";
    sha256 = "sha256-N7uUpMB8g3g6shTjw2MmvzsoCZ+beEIUi1zpafIj7+U=";
  };

  buildInputs = [
    pkgs.gcc
  ];

  installPhase = ''
    make
    make install PREFIX=$out
  '';
}
