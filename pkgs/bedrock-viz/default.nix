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
    broken = true;
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
    sed -i 's/#include <zlib.h>/#include <zlib.h>\n#include <cstdint>/' \
      /build/source/third_party/leveldb/table/compressor/zlib_compressor.cc
    sed -i 's/if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")/if (TRUE)/g' \
      /build/source/CMakeLists.txt
    cat /build/source/CMakeLists.txt
  '';

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
  ];
}
