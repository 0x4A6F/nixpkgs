{ stdenv, fetchFromGitHub, rustPlatform }:

rustPlatform.buildRustPackage rec {
  pname = "grex";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "pemistahl";
    repo = pname;
    rev = "v${version}";
    sha256 = "1viph7ki6f2akc5mpbgycacndmxnv088ybfji2bfdbi5jnpyavvs";
  };

  cargoSha256 = "0kf2n2j7kfrfzid1h2gd0qf53fah0hpyrrlh2k5vrhd0panv3bwc";

  meta = with stdenv.lib; {
    description = "A command-line tool and library for generating regular expressions from user-provided test cases";
    homepage = "https://github.com/pemistahl/grex";
    license = licenses.asl20;
    maintainers = [ maintainers."0x4A6F" ];
    platforms = platforms.linux;
  };
}
