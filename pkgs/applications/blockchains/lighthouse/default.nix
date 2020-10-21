{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "lighthouse";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "sigp";
    repo = pname;
    rev = "v${version}";
    sha256 = "1clilsrbmbjbf002mq0bwwnrbd2rzh35mnwpx1y1f4lqdhmrnc8b";
  };

  cargoSha256 = "sha256:0yj7c0qn5vhd68m3g0d1izkpyjbaki3mrs80vms4am99knjx65ri";

  meta = with stdenv.lib; {
    description = "Rust Ethereum 2.0 Client";
    homepage = "https://github.com/sigp/lighthouse";
    license = licenses.asl20;
    maintainers = with maintainers; [ _0x4A6F ];
    platforms = platforms.linux;
  };
}
