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
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
          uptix = (args.uptix.nixosModules.uptix ./uptix.lock { inherit pkgs; })._module.args.uptix;
        in
        import ./default.nix {
          inherit pkgs uptix;
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
