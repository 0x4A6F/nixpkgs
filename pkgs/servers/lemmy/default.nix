{ stdenv
, fetchFromGitHub
, rustPlatform
, cmake
, pkg-config
, openssl
, postgresql
, espeak
}:

rustPlatform.buildRustPackage rec {
  pname = "lemmy";
  version = "0.8.4";

  src = fetchFromGitHub {
    owner = "LemmyNet";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Kz9cmTzLJ/QOizyphnckPSTSpfV5ANfDp1XsqoefTlE=";
  };

  cargoSha256 = "12hhzhh3z8ib5jdkr1nggwdmg6a32fbxiarp5vfxl84fg2jcb929";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    openssl
    espeak
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
