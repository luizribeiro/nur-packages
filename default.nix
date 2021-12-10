{ pkgs ? import <nixpkgs> { } }:

{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  dokku-client = pkgs.callPackage ./pkgs/dokku-client { inherit pkgs; };
  ps5-wake = pkgs.callPackage ./pkgs/ps5-wake { inherit pkgs; };
}
