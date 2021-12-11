{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "influx-cli";
  version = "2.2.1";

  src = fetchFromGitHub {
    owner = "influxdata";
    repo = "influx-cli";
    rev = "v${version}";
    sha256 = "sha256-9FUchI93xLpQwtpbr5S3GfVrApHaemwbnRPIfAWmG6Y=";
  };

  vendorSha256 = "sha256-G9S7gAuDNwxADekOr9AaXDkPDSXVlc9Fi4gdrKdy0rI=";

  meta = with lib; {
    homepage = "https://github.com/influxdata/influx-cli";
    description = "CLI for managing resources in InfluxDB v2";
    license = licenses.mit;
  };
}
