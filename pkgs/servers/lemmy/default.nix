{ stdenv
, fetchFromGitHub
, rustPlatform
, cmake
, pkg-config
, openssl
, postgresql
#, espeak
}:

rustPlatform.buildRustPackage rec {
  pname = "lemmy";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "LemmyNet";
    repo = pname;
    rev = "v${version}";
    sha256 = "00n4lmm9b92rhcday9dy8r42dwww3s2x7wx0zyk55vh8szzxhxag";
  };

  cargoSha256 = "sha256:1vk3fmm9i1icarpb93f1xb611wj1i29ky3s8afmk18n97b6h4xi5";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    openssl
#    espeak
    postgresql
  ];

  meta = with stdenv.lib; {
    description = "Building a federated alternative to reddit in rust";
    homepage = "https://github.com/LemmyNet/lemmy";
    license = licenses.agpl3;
    maintainers = with maintainers; [ _0x4A6F ];
    platforms = platforms.linux;
  };
}
