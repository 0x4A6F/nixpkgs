{ lib
, buildGoModule
, fetchFromGitea
, pkg-config
, xlibsWrapper
, libXcursor
, libXrandr
, libXinerama
, libXi
, libGLU
, mesa
}:

buildGoModule rec {
  pname = "itd";
  version = "0.0.4";

  src = fetchFromGitea {
    domain = "gitea.arsenm.dev";
    owner = "Arsen6331";
    repo = "itd";
    rev = "v${version}";
    sha256 = "sha256-GpYX7eiPcwLZEuLu9goZ20QFeP+BzXD8w9IK79B1EDk=";
  };

  vendorSha256 = "sha256-lHrjTQxzmUMycNcda+YvgKXIKmtv0TDXUD/xDDr3+OI=";

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    xlibsWrapper
    libXcursor
    libXrandr
    libXinerama
    libXi
    libGLU
    mesa
  ];

  meta = with lib; {
    description = "A daemon to interact with the PineTime smartwatch";
    homepage = "https://gitea.arsenm.dev/Arsen6331/itd/";
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
    maintainers = with maintainers; [ _0x4A6F ];
  };
}
