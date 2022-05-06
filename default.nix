{ pkgs ? import <nixpkgs> { }, uptix ? null } @ inputs:

{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;

  alfred = pkgs.callPackage ./pkgs/alfred inputs;
  bedrock-viz = pkgs.callPackage ./pkgs/bedrock-viz inputs;
  dokku-client = pkgs.callPackage ./pkgs/dokku-client inputs;
  influx-cli = pkgs.callPackage ./pkgs/influx-cli inputs;
  ps5-wake = pkgs.callPackage ./pkgs/ps5-wake inputs;
  virtualhere-client = pkgs.callPackage ./pkgs/virtualhere-client inputs;
  virtualhere-server = pkgs.callPackage ./pkgs/virtualhere-server inputs;
}
