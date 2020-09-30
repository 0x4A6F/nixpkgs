{ stdenv
, fetchFromGitHub
, qubes-core-vchan-xen
, pkgconfig
, pam
, pandoc
, lsb-release
, python3
, pythonPackages
}:

stdenv.mkDerivation rec {
  pname = "qubes-core-qrexec";
  version = "4.1.8";

  src = fetchFromGitHub {
    owner = "QubesOS";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256:0dja161ppvzvz0i597iba6vz2x9x5zg4mz9x4wkziv7w1k0j5q1k";
  };

  nativeBuildInputs = with pythonPackages; [
    pkgconfig
    qubes-core-vchan-xen
    lsb-release
    python3
    setuptools
  ];

  buildInputs = [
    qubes-core-vchan-xen
    pam
    pandoc
  ];

  buildPhase = ''
    export BACKEND_VMM="xen"
    make all-base all-vm DESTDIR=$out PREFIX=/ LIBDIR=$out/include
  # make all-base DESTDIR=$out PREFIX=/ LIBDIR=$out/include
  # make all-vm DESTDIR=$out PREFIX=/ LIBDIR=$out/include
  # make all-dom0 DESTDIR=$out PREFIX=/ LIBDIR=$out/include
  '';

  installPhase = ''
    make install-base install-vm DESTDIR=$out PREFIX=/
  # make install-base DESTDIR=$out PREFIX=/
  # make install-vm DESTDIR=$out PREFIX=/
  # make install-dom0 DESTDIR=$out PREFIX=/
  '';

  meta = with stdenv.lib; {
    description = "Qubes OS Remote Procedure Call (RPC) protocol";
    homepage = "https://github.com/QubesOS/qubes-core-qrexec";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ _0x4A6F ];
    platforms = platforms.unix;
  };
}
