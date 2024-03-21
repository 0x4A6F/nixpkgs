{ lib
, stdenv
, fetchFromGitHub
, cmake
, acl
, asciidoc
, attr
, bc
, build-essential
, ca-certificates-java
, ccache
, curl
, debhelper
, devscripts
, fuse3
, git
, libblkid-dev
, libboost-filesystem-dev
, libboost-iostreams-dev
, libboost-program-options-dev
, libboost-system-dev
, libcrcutil-dev
, libdb-dev
, fmt_10 # -> ibfmt-dev
, libfuse3-dev
, libgoogle-perftools-dev
, libgtest-dev
, libisal-dev
, libjudy-dev
, libpam0g-dev
, libspdlog-dev
, libsystemd-dev
, liburcu-dev
, libyaml-cpp-dev
, lsb-release
, netcat-openbsd
, nfs4-acl-tools
, pkg-config
, pylint
, python3
, python3-pip
, rsync
, socat
, sudo
, tidy
, time
, uuid-dev
, valgrind
, wget
, zlib1g-dev
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
