{ uptix, stdenv, pkgs, lib, ... }:

stdenv.mkDerivation {
  name = "bedrock-viz";

  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "bedrock-viz";
    repo = "bedrock-viz";
    branch = "master";
    fetchSubmodules = true;
    deepClone = true;
  });

  meta = with lib; {
    platforms = platforms.linux;
  };

  nativeBuildInputs = with pkgs; [
    boost
    cmake
    git
    libpng
  ];

  setSourceRoot = "sourceRoot=`pwd`";

  prePatch = ''
    cd source
    git apply -p0 patches/leveldb-1.22.patch
    git apply -p0 patches/pugixml-disable-install.patch    
  '';

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
  ];
}
