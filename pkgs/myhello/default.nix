{ stdenv }:

stdenv.mkDerivation {
  pname = "my-hello";
  version = "1.0";
  builder = ./builder.sh;
}
