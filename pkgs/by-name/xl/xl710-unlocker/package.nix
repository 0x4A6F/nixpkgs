{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "xl710-unlocker";
  version = "unstable-2017-12-14";

  src = fetchFromGitHub {
    owner = "bibigon812";
    repo = "xl710-unlocker";
    rev = "486435437826ab292f3f9d9b8651aa159447cb3b";
    hash = "sha256-nq8PWld8xN/tlic7noQmPST7gvbQP6DS8XlNIGGCwIk=";
  };

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp -r xl710_unlock $out/bin/
    chmod +x $out/bin/xl710_unlock
  '';

  meta = {
    description = "Unlock Intel XL710 / X710 cards for use with any SFP";
    homepage = "https://github.com/bibigon812/xl710-unlocker";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ _0x4A6F ];
    mainProgram = "xl710_unlock";
    platforms = lib.platforms.all;
  };
}
