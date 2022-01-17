{ stdenv, pkgs, lib, ... }:

stdenv.mkDerivation {
  name = "bedrock-viz";

  src = pkgs.fetchFromGitHub {
    owner = "bedrock-viz";
    repo = "bedrock-viz";
    rev = "af672b9182bcdb338351a252bdba2dff8ac190b4";
    sha256 = "sha256-sICYtdBaXh95nerYfeqhMFmLa5eepgKmES4WCxKXW/0=";
    fetchSubmodules = true;
    deepClone = true;
  };

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
