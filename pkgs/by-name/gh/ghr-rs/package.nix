{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, libgit2
, openssl
, zlib
, zstd
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "ghr-rs";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "siketyan";
    repo = "ghr";
    rev = "v${version}";
    hash = "sha256-W5zkDNge0x/oFnwnip12SfCxtZ5nAQ5c3rUAnIMZ5L0=";
  };

  cargoHash = "sha256-MHgOQRBWj9UfG9U7/qjJ6rAa/SAdd3vV332OfwYHEqM=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libgit2
    openssl
    zlib
    zstd
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = with lib; {
    description = "Yet another repository management with auto-attaching profiles";
    homepage = "https://github.com/siketyan/ghr";
    license = licenses.mit;
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "ghr";
  };
}
