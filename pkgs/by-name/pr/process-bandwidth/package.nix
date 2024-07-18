{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "process-bandwidth";
  version = "0.3.2";

  src = fetchFromGitHub {
    owner = "Ivlyth";
    repo = "process-bandwidth";
    rev = "v${version}";
    hash = "sha256-5KRDdhAOD809UiPuoJ2EcHqRd9xIs0MQ2yThYI/Foig=";
  };

  vendorHash = "sha256-B5rhpgfAQ7Xev1fkgLGc2sliJYNyCsDPKV23fnE1KOs=";

  ldflags = [
    "-s"
    "-w"
  ];

  meta = with lib; {
    description = "An ebpf based program which focus on process's network bandwidth, like Nethogs but provides every connection's bandwidth as well, and even terminal graph";
    homepage = "https://github.com/Ivlyth/process-bandwidth";
    license = licenses.mit;
    maintainers = with maintainers; [ _0x4A6F ];
    mainProgram = "process-bandwidth";
  };
}
