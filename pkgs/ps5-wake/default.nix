{ pkgs, lib, uptix, ... }:

# Statically linked against musl, since the binary runs inside the Home
# Assistant container, which doesn't have the NixOS host's glibc.
pkgs.pkgsStatic.stdenv.mkDerivation {
  name = "ps5-wake";

  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "iharosi";
    repo = "ps5-wake";
    branch = "master";
  });

  meta = with lib; {
    platforms = platforms.linux;
  };

  buildPhase = ''
    make CC="$CC"
  '';
  installPhase = ''
    make install PREFIX=$out CC="$CC"
  '';
}
