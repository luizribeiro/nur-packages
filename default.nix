{ pkgs ? import <nixpkgs> { } }:

{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  alfred = pkgs.callPackage ./pkgs/alfred { };
  dokku-client = pkgs.callPackage ./pkgs/dokku-client { inherit pkgs; };
  influx-cli = pkgs.callPackage ./pkgs/influx-cli { };
  ps5-wake = pkgs.callPackage ./pkgs/ps5-wake { inherit pkgs; };
}
