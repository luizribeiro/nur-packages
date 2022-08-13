{ lib, stdenv, pkgs, uptix }:

stdenv.mkDerivation {
  name = "opensprinkler";
  buildInputs = with pkgs; [ mosquitto ];

  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "OpenSprinkler";
    repo = "OpenSprinkler-Firmware";
    branch = "master";
  });

  sourceRoot = ".";

  buildPhase = ''
    cd source
    g++ -std=c++14 -o opensprinkler -DOSPI \
      main.cpp OpenSprinkler.cpp program.cpp opensprinkler_server.cpp \
      utils.cpp weather.cpp gpio.cpp etherport.cpp mqtt.cpp \
      -lpthread -lmosquitto
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp opensprinkler $out/bin
  '';

  meta = {
    description = "Software used for controlling OpenSprinkler Pi";
    homepage = "https://github.com/OpenSprinkler/OpenSprinkler-Firmware";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
}
