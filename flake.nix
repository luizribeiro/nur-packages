{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.uptix.url = "github:luizribeiro/uptix";
  outputs = { self, nixpkgs, uptix } @ args:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
      uptix = (args.uptix.nixosModules.uptix ./uptix.lock)._module.args.uptix;
    in
    {
      packages = forAllSystems (system: import ./default.nix {
        pkgs = import nixpkgs { inherit system; };
        inherit uptix;
      });
      devShell = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.mkShell {
          buildInputs = [
            args.uptix.defaultPackage."${system}"
          ];
        }
      );
    };
}
