{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, libgit2
, openssl
, zlib
, stdenv
, darwin
}:

rustPlatform.buildRustPackage rec {
  pname = "comtrya";
  version = "0.8.8";

  src = fetchFromGitHub {
    owner = "comtrya";
    repo = "comtrya";
    rev = "v${version}";
    hash = "sha256-KCs+Li4giSCOPjyEZXaw7Tl+POZmyAREcfyyQXQ3No4=";
  };

  cargoHash = "sha256-1PHDRaEqXuGqMQwDlRSE/rjmCuSK4XyWiHniINPwB1E=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    libgit2
    openssl
    zlib
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreFoundation
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ];

  env = {
    OPENSSL_NO_VENDOR = true;
  };

  checkFlags = [
    # reason for disabling test
    "--skip=actions::group::providers::linux::test::test_add_group"
    "--skip=actions::package::install::tests::it_can_be_deserialized"
    "--skip=actions::package::providers::aptitude::test::test_add_repository_with_key"
    "--skip=actions::package::providers::aptitude::test::test_add_repository_without_key"
    "--skip=actions::package::providers::dnf::test::test_add_repository_without_key"
    "--skip=actions::user::providers::linux::test::test_add_to_group"
    "--skip=actions::user::providers::linux::test::test_add_user"
    "--skip=actions::user::providers::linux::test::test_create_user_add_to_group"
    "--skip=atoms::file::chown::tests::it_can"
    "--skip=atoms::git::clone::tests::it_can_execute"
    "--skip=atoms::http::download::tests::it_can"
    "--skip=manifests::providers::git::test::test_resolve"
  ];

  meta = with lib; {
    description = "Configuration Management for Localhost / dotfiles";
    homepage = "https://github.com/comtrya/comtrya";
    license = licenses.mit;
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "comtrya";
  };
}
