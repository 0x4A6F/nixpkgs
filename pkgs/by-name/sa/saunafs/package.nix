{ lib
, fetchFromGitHub
, cmake
, acl
, fmt_10
, spdlog
, yaml-cpp
, fuse3
, pkg-config
, zlib
, zstd
, bzip2
, lzma
, boost175
, judy
, linux-pam
, db
, gcc11Stdenv
}:

gcc11Stdenv.mkDerivation rec {
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
    acl
    fmt_10
    spdlog
    (yaml-cpp.override { stdenv = gcc11Stdenv; })
    fuse3
    pkg-config
    (boost175.override { stdenv = gcc11Stdenv; })
    judy
    linux-pam
    db
    zlib
    zstd
    lzma
    bzip2
  ];

  cmakeFlags = [
    "-DENABLE_CLIENT_LIB=ON"
    "-DENABLE_NFS_GANESHA=OFF"
    "-DENABLE_WERROR=ON"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DENABLE_CCACHE=OFF"
  ];

  meta = with lib; {
    description = "A distributed POSIX file system inspired by Google File System";
    homepage = "https://saunafs.com";
    changelog = "https://github.com/leil-io/saunafs/blob/${src.rev}/NEWS";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ _0x4A6F cheriimoya ];
    mainProgram = "saunafs";
    platforms = platforms.all;
  };
}
