{ stdenv, fetchurl, pkgs, cmake, bison, pkgconfig, doxygen, libsodium, libcap, libuecc, json_c }:

stdenv.mkDerivation rec {
  version = "17";
  name = "fastd-v${version}";

  src = fetchurl {
    url = "https://git.universe-factory.net/fastd/snapshot/fastd-17.tar";
    sha256 = "20390fc2110929ebf37feebe1bcce68d7920a5efd42c369bd2d886c6781966dc";
  };

  buildInputs = [ libsodium libcap libuecc json_c ];

  nativeBuildInputs = [ cmake bison pkgconfig doxygen ];

  meta = with stdenv.lib; {
    inherit version;
    homepage = "https://projects.universe-factory.net/projects/fastd/wiki";
    downloadPage = "https://git.universe-factory.net/fastd/";
    description = "Fast and Secure Tunneling Daemon";
  # longDescription = "FIXME";
    license = with licenses; [ bsd2 ];
    maintainers = with maintainers; [ 0x4A6F ];
    platforms = platforms.all;
  };
}
