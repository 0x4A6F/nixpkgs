{ stdenv, fetchFromGitHub, rustPlatform, rsync }:

rustPlatform.buildRustPackage rec {
  pname = "routinator";
  version = "0.3.3";

  src = fetchFromGitHub {
    owner = "NLnetLabs";
    repo = pname;
    rev = "v${version}";
    sha256 = "1fj12ip2h0iprsf1ymf79c54s00qscazk69zvz04a71yqnrls89m";
  };

  cargoSha256 = "1l6nbq4vdjsn6cqnzgrbhk95wds8jf9ghv1shjpm5xjigsb1yzgl";

  meta = with stdenv.lib; {
    description = "An RPKI Validator written in Rust";
    homepage = "https://github.com/NLnetLabs/routinator";
    license = licenses.bsd3;
    maintainers = [ maintainers."0x4A6F" ];
    platforms = platforms.all;
  };
}
