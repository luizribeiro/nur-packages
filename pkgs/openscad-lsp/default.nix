{ uptix, pkgs, rustPlatform, ... }:

rustPlatform.buildRustPackage {
  name = "openscad-lsp";
  src = pkgs.fetchFromGitHub (uptix.githubBranch {
    owner = "Leathong";
    repo = "openscad-LSP";
    branch = "master";
  });
  cargoHash = "sha256-/OEamj/4+8Zu/XCOtJy4tBtK6fZ6VjLg61Ir7EnCh/I=";
  meta = {
    description = "A LSP server for OpenSCAD";
    homepage = "https://github.com/Leathong/openscad-LSP";
    license = pkgs.lib.licenses.asl20;
    platforms = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
  };
}
