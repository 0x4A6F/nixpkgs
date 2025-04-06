{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  bzip2,
  xz,
  zstd,
}:

rustPlatform.buildRustPackage rec {
  pname = "nix-check-deps";
  version = "unstable-2025-04-06";

  src = fetchFromGitHub {
    owner = "LordGrimmauld";
    repo = "nix-check-deps";
    rev = "99c4875b81197666f2f254302aa31b2b50484580";
    hash = "sha256-lswlQzktKAXKkhwjqmdbg0dVKuEj36/sXP+f+fG+jbE=";
  };

  cargoHash = "sha256-5VBnvEDIvaIsiNPkU4mMaNIqNJ7o/DljfAx4TXVcVIg=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    bzip2
    xz
    zstd
  ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "Scan nix packages for unused buildInputs";
    homepage = "https://github.com/LordGrimmauld/nix-check-deps";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "nix-check-deps";
  };
}
