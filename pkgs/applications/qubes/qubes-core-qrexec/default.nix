{ stdenv
, fetchFromGitHub
, qubes-core-vchan-xen
, pkgconfig
, pam
, pandoc
, lsb-release
}:

stdenv.mkDerivation rec {
  pname = "qubes-core-qrexec";
  version = "4.1.1";

  src = fetchFromGitHub {
    owner = "QubesOS";
    repo = pname;
    rev = "v${version}";
    sha256 = "0clkkk4vw7fxydxkwwrgvbf3f05r30wxpg2qrmpym5fmbs6y8gic";
  };

  nativeBuildInputs = [
    pkgconfig
    qubes-core-vchan-xen
    lsb-release
  ];
  buildInputs = [
    qubes-core-vchan-xen
    pam
    pandoc
  ];

  buildPhase = ''
    export PKG_CONFIG_PATH="${qubes-core-vchan-xen}:$PKG_CONFIG_PATH"
    export BACKEND_VMM="xen"
    make all-vm PREFIX=/
  '';
  installPhase = ''
    make install-vm DESTDIR=$out PREFIX=/
  '';

  meta = with stdenv.lib; {
    description = "";
    homepage = "https://github.com/QubesOS/qubes-core-qrexec";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ "0x4A6F" ];
    platforms = platforms.unix;
  };
}
