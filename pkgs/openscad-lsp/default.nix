{ uptix, pkgs, lib, rustPlatform, ... }:

rustPlatform.buildRustPackage {
  name = "openscad-lsp";
  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "Leathong";
    repo = "openscad-LSP";
    branch = "master";
  });
  cargoHash = "sha256-IQAqrc/Wcn8eKezMeKwlX4BCp7cYrbSoMoNDSf2lmCI=";
  meta = {
    description = "A LSP server for OpenSCAD";
    homepage = "https://github.com/Leathong/openscad-LSP";
    license = pkgs.lib.licenses.asl20;
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
