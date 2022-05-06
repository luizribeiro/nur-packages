{ stdenv, pkgs, lib, uptix, ... }:

stdenv.mkDerivation {
  name = "ps5-wake";

  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "iharosi";
    repo = "ps5-wake";
    branch = "master";
  });

  meta = with lib; {
    platforms = platforms.linux;
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
