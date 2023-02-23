{ pkgs ? import <nixpkgs> { }, uptix ? import ./uptix.nix } @ inputs:

{
  lib = import ./lib { inherit pkgs; };
  modules = import ./modules;
  overlays = import ./overlays;
} // builtins.mapAttrs
  (name: _type: pkgs.callPackage (./pkgs + "/${name}") inputs)
  (pkgs.lib.filterAttrs
    (_name: type: type == "directory")
    (builtins.readDir ./pkgs)
  )
