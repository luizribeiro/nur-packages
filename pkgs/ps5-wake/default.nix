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
    # compile and statically link using musl-gcc, since I run this
    # binary from docker which doesn't have access to glibc from the
    # nixos host
    pkgs.musl
  ];

  buildPhase = ''
    make CC="musl-gcc -static"
  '';
  installPhase = ''
    make install PREFIX=$out CC="musl-gcc -static"
  '';
}
