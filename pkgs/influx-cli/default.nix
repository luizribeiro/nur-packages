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
  vendorSha256 = "sha256-Boz1G8g0fjjlflxZh4V8sd/v0bE9Oy3DpqywOpKxjd0=";
  meta = with lib; {
    homepage = "https://github.com/influxdata/influx-cli";
    description = "CLI for managing resources in InfluxDB v2";
    license = licenses.mit;
  };
}
