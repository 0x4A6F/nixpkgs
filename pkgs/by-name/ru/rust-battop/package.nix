{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "rust-battop";
  version = "0.2.4";

  src = fetchFromGitHub {
    owner = "svartalf";
    repo = "rust-battop";
    rev = "v${version}";
    hash = "sha256-PHh1bL9ESc5PXbq4JoT+l7/UkMz/w+1ETTxckQeVo1w=";
  };

  cargoHash = "sha256-N05T7GkyPHVyZEUnOCqO9oVXw12JHnHJT8JtKprkPsU=";

  meta = with lib; {
    description = "Interactive batteries viewer";
    homepage = "https://github.com/svartalf/rust-battop";
    changelog = "https://github.com/svartalf/rust-battop/blob/${src.rev}/CHANGELOG.md";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ ];
    mainProgram = "rust-battop";
  };
}
