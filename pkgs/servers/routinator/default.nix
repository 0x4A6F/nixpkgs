{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "routinator";
  version = "0.8.0-rc1";

  src = fetchFromGitHub {
    owner = "NLnetLabs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256:0nz18c4iq8333y7y3lqjglmr2sbprzb4714zw1i6dky6kssg2vqb";
  };

  cargoSha256 = "sha256:174agf89jgak70hmdijzp81vjvf3x8a84bzicgqq7hv6pfq2jjff";

  meta = with stdenv.lib; {
    description = "An RPKI Validator written in Rust";
    homepage = "https://github.com/NLnetLabs/routinator";
    license = licenses.bsd3;
    maintainers = [ maintainers."0x4A6F" ];
    platforms = platforms.linux;
  };
}
