{ stdenv, fetchFromGitHub, pkgs, cmake, pkgconfig, doxygen, libuecc }:

stdenv.mkDerivation rec {
  version = "0.3.2";
  name = "ecdsautils-v${version}";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "tcatm";
    repo = "ecdsautils";
    sha256 = "03p8pb9fd020fcqwxw4zhvfjv6cczw8hxqa4m9ldjh1iwqfhgrlj";
  };

  buildInputs = [ libuecc ];

  nativeBuildInputs = [ cmake pkgconfig doxygen ];

  meta = with stdenv.lib; {
    inherit version;
    homepage = "https://github.com/tcatm/ecdsautils";
    downloadPage = "https://github.com/tcatm/ecdsautils";
    description = "Programs used for ECDSA (keygen, sign, verify)";
    longDescription = "Tiny collection of programs used for ECDSA (keygen, sign, verify)";
    license = with licenses; [ bsd2 ];
    maintainers = with maintainers; [ 0x4A6F ];
    platforms = platforms.all;
  };
}
