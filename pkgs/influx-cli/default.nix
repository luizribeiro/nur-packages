{ buildGoModule, fetchFromGitHub, lib, uptix, ... }:

let
  release = uptix.githubRelease {
    owner = "influxdata";
    repo = "influx-cli";
  };
in
buildGoModule {
  pname = "influx-cli";
  version = uptix.version release;
  src = fetchFromGitHub release;
  vendorHash = "sha256-QNhL5RPkNLTXoQ0NqcZuKec3ZBc3CDTc/XTWvjy55wk=";
  meta = with lib; {
    homepage = "https://github.com/influxdata/influx-cli";
    description = "CLI for managing resources in InfluxDB v2";
    license = licenses.mit;
  };
}
