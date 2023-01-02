{ buildGoModule, fetchFromGitHub, lib, uptix, ... }:

let
  release = uptix.githubRelease {
    owner = "influxdata";
    repo = "influx-cli";
  };
in
buildGoModule rec {
  pname = "influx-cli";
  version = uptix.version release;
  src = fetchFromGitHub release;
  vendorSha256 = "sha256-TnPvozwp7bU4BRu3gYce1jyuMClo5YiMGskXZvZqstA=";
  meta = with lib; {
    homepage = "https://github.com/influxdata/influx-cli";
    description = "CLI for managing resources in InfluxDB v2";
    license = licenses.mit;
  };
}
