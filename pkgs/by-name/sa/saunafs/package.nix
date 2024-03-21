{ lib
, stdenv
, fetchFromGitHub
, cmake
, fmt_10
, spdlog
, yaml-cpp
, fuse3
, boost175
}:

stdenv.mkDerivation rec {
  pname = "saunafs";
  version = "4.0.1";

  src = fetchFromGitHub {
    owner = "leil-io";
    repo = "saunafs";
    rev = "v${version}";
    hash = "sha256-R9a0AfG/SS95TQVB34fst05cZpmqupWW/XN+1ehbTf8=";
  };

  nativeBuildInputs = [
    cmake
    fmt_10
    spdlog
    yaml-cpp
    fuse3
    boost175
  ];

  meta = with lib; {
    description = "A distributed POSIX file system inspired by Google File System";
    homepage = "https://github.com/leil-io/saunafs";
    changelog = "https://github.com/leil-io/saunafs/blob/${src.rev}/NEWS";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "saunafs";
    platforms = platforms.all;
  };
}
