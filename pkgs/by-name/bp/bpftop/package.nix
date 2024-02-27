{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
}:

rustPlatform.buildRustPackage rec {
  pname = "bpftop";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "Netflix";
    repo = "bpftop";
    rev = "v${version}";
    hash = "sha256-1Wgfe+M1s3hxcN9g1KiBeZycdgpMiHy5FWlE0jlNq/U=";
  };

  cargoHash = "sha256-CrAH3B3dCg3GsxvRrVp/jx3YSpmEg4/jyNuXUO/zeq0=";

  nativeBuildInputs = [
    pkg-config
  ];

  meta = with lib; {
    description = "Bpftop provides a dynamic real-time view of running eBPF programs. It displays the average runtime, events per second, and estimated total CPU % for each program";
    homepage = "https://github.com/Netflix/bpftop";
    license = licenses.asl20;
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "bpftop";
  };
}
