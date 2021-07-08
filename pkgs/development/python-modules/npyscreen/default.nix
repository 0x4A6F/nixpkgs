{ lib
, buildPythonPackage
, fetchPypi
, fetchFromBitbucket
, fetchFromGitHub
, backports_weakref
}:

buildPythonPackage rec {
  pname = "npyscreen";
  version = "4.10.5";

#  src = fetchPypi {
#    inherit pname version;
#    sha256 = "0vhjwn0dan3zmffvh80dxb4x67jysvvf1imp6pk4dsfslpwy0bk2";
#  };

#  src = fetchFromBitbucket {
#    owner = "npcole";
#    repo = pname;
#    rev = "1008:cb5c0736d22a";
#    sha256 = "1zwyi639i347h88xki7qvpmdg9qidgqx393allqf5a2dlkryjmfa";
#  };

  src = fetchFromGitHub {
    owner = "jwoglom";
    repo = pname;
    rev = "d01ce55df23ff1596ff874f20b85a1270f42b015";
    sha256 = "0cpi367ll3s46v5z1wz04jycd2lxc975020nn9acia1h0x3ljvwc";
  };

#  checkInputs = [
#    backports_weakref
#  ];

  doCheck = false;

  meta = with lib; {
    homepage = "https://npyscreen.readthedocs.io/";
    description = "python widget library and application framework for programming terminal or console applications";
    license = licenses.bsd2;
    maintainers = with maintainers; [ "0x4A6F" ];
  };
}

