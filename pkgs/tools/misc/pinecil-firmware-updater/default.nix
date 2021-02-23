{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, qtbase
, qmake
, makeWrapper
, mkDerivation
, libusb1
, dfu-util
}:

mkDerivation rec {
  pname = "pinecil-firmware-updater";
  version = "1.3";

  src = fetchFromGitHub {
    owner = "pine64";
    repo = "pinecil-firmware-updater";
    rev = version;
    sha256 = "05dyn4ah94als6afcg75mzfv4agzfhn043s9r3kcgqgwk2bglbfv";
  };

  patches = [
    ./pinecil_firmware_updater.pro.patch
    ./flashingthread.cpp.patch
  ];
  postPatch = ''
    printf "INSTALLS += target\ntarget.path = $out/bin" >>  pinecil_firmware_updater.pro

    substituteInPlace flashingthread.cpp \
      --replace 'REPLACE-dfu-util' '${dfu-util}/bin/dfu-util'
  '';

  nativeBuildInputs = [
    pkg-config
    qmake
    makeWrapper
  ];
  buildInputs = [
    qtbase
    dfu-util
    libusb1
  ];

  meta = with lib; {
    homepage = "https://github.com/pine64/pinecil-firmware-updater";
    description = "Application for updating Pinecil soldering iron";
    license = licenses.asl20;
    platforms = platforms.unix;
  };
}
