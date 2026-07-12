{
  lib,
  buildGoModule,
  fetchFromGitHub,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  pname = "prometheus-paperless-exporter";
  version = "0.0.9";
  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "hansmi";
    repo = "prometheus-paperless-exporter";
    tag = "v${finalAttrs.version}";
    hash = "sha256-KY2PvIvmTaM/p4v3LScAG7Q1HmZG/afEmgvy1iSGHAU=";
  };

  vendorHash = "sha256-JDcGV11v2cNXaLhlcuJH0aM1v1hJADZbtZWZ9dPj894=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/prometheus/common/version.Version=${finalAttrs.version}"
    "-X=github.com/prometheus/common/version.Revision=${finalAttrs.src.rev}"
    "-X=github.com/prometheus/common/version.Branch=${finalAttrs.src.rev}"
    "-X=github.com/prometheus/common/version.BuildDate=1970-01-01T00:00:00Z"
  ];

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Paperless-ngx metrics for Prometheus";
    homepage = "https://github.com/hansmi/prometheus-paperless-exporter";
    changelog = "https://github.com/hansmi/prometheus-paperless-exporter/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "prometheus-paperless-exporter";
  };
})
