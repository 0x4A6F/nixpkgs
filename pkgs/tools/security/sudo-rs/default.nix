{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pam
}:

rustPlatform.buildRustPackage rec {
  pname = "sudo-rs";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "memorysafety";
    repo = "sudo-rs";
    rev = "v${version}";
    hash = "sha256-Kk5D3387hdl6eGWTSV003r+XajuDh6YgHuqYlj9NnaQ=";
  };

  cargoHash = "sha256-yeMK37tOgJcs9pW3IclpR5WMXx0gMDJ2wcmInxJYbQ8=";

  buildInputs = [
    pam
  ];

  checkFlags = [
    # TODO: fix tests
    "--skip=common::command::test::test_build_command_and_args"
    "--skip=common::context::tests::test_build_context"
    "--skip=common::resolve::test::canonicalization"
    "--skip=common::resolve::tests::test_resolve_path"
    "--skip=env::environment::tests::test_tzinfo"
    "--skip=env::tests::test_environment_variable_filtering"
    "--skip=su::context::tests::invalid_shell"
    "--skip=su::context::tests::su_to_root"
    "--skip=system::audit::test::secure_open_is_predictable"
    "--skip=system::interface::test::test_unix_group"
    "--skip=system::interface::test::test_unix_user"
    "--skip=system::tests::kill_test"
    "--skip=system::tests::test_get_user_and_group_by_id"
  ];

  meta = with lib; {
    description = "A memory safe implementation of sudo and su";
    homepage = "https://github.com/memorysafety/sudo-rs";
    changelog = "https://github.com/memorysafety/sudo-rs/blob/${src.rev}/CHANGELOG.md";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "sudo-rs";
  };
}
