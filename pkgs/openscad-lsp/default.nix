{ uptix, pkgs, lib, rustPlatform, ... }:

rustPlatform.buildRustPackage {
  name = "openscad-lsp";
  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "Leathong";
    repo = "openscad-LSP";
    branch = "master";
  });
  cargoSha256 = "sha256-ab3e3Jw9Ev3/qHA0Jj03ar5b/yJ9R//NdLuvnTkKO3I=";
  meta = {
    description = "A LSP server for OpenSCAD";
    homepage = "https://github.com/Leathong/openscad-LSP";
    license = pkgs.lib.licenses.asl20;
    platforms = [ "x86_64-linux" "x86_64-darwin" ];
  };
}
