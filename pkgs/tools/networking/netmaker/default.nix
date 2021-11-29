{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule rec {
  pname = "netmaker";
  version = "0.9.1";

  src = fetchFromGitHub {
    owner = "gravitl";
    repo = "netmaker";
    rev = "v${version}";
    sha256 = "13kqbvgbjdp8p1zwl2ppgqxi2dd9khizx0xvwjqvcnrxzaqk3g8c";
  };
  vendorSha256 = "1rg2xwnxbkyr9czkvnr51r7cm1hb5x6qaj3218gsgkncf72246ak";

  doCheck = false;

  meta = with lib; {
    description = "Automates fast, secure, and distributed virtual networks with WireGuard";
    homepage = "https://github.com/gravitl/netmaker/";
    license = licenses.unfree;
    maintainers = with maintainers; [ _0x4A6F ];
  };
}
