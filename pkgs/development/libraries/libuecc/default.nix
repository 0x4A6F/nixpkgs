{ stdenv, fetchurl, pkgs, cmake, pkgconfig, doxygen }:

stdenv.mkDerivation rec {
  version = "6";
  name = "libuecc-v${version}";

  src = fetchurl {
    url = "https://git.universe-factory.net/libuecc/snapshot/libuecc-6.tar";
    sha256 = "fe61715b7cd8458616840f71ab8c0c7e5f49480a9cfb2c1965fbb9d713f071b6";
  };

  nativeBuildInputs = [ cmake pkgconfig doxygen ];

  meta = with stdenv.lib; {
    inherit version;
    homepage = "https://git.universe-factory.net/libuecc/";
  # downloadPage = "";
    description = "Very small Elliptic Curve Cryptography library";
  # longDescription = "FIXME";
    license = with licenses; [ bsd2 ];
    maintainers = with maintainers; [ 0x4A6F ];
    platforms = platforms.all;
  };
}
