{ pkgs ? import <nixpkgs> { } }:

{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  alfred = pkgs.callPackage ./pkgs/alfred { };
  bedrock-viz = pkgs.callPackage ./pkgs/bedrock-viz { inherit pkgs; };
  dokku-client = pkgs.callPackage ./pkgs/dokku-client { inherit pkgs; };
  influx-cli = pkgs.callPackage ./pkgs/influx-cli { };
  ps5-wake = pkgs.callPackage ./pkgs/ps5-wake { inherit pkgs; };
  virtualhere-client = pkgs.callPackage ./pkgs/virtualhere-client { inherit pkgs; };
  virtualhere-server = pkgs.callPackage ./pkgs/virtualhere-server { inherit pkgs; };
}
