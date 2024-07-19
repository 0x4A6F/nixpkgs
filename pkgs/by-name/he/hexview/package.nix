{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "hexview";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "tertsdiepraam";
    repo = "hexview";
    rev = "v${finalAttrs.version}";
    hash = "sha256-e3Cd9UZsGM9nytjQj1lOOfuzQKE8AQuwUJ10Ze407+U=";
  };

  cargoHash = "sha256-EJq4b3onHufmyLIYqxv5OTnLAgbBPhp60RshlAV+prA=";

  meta = {
    description = "TUI Hex viewer written in Rust";
    homepage = "https://github.com/tertsdiepraam/hexview";
    license = with lib.licenses; [
      asl20 # or
      mit
    ];
    maintainers = with lib.maintainers; [ _0x4A6F ];
    mainProgram = "hexview";
  };
})
