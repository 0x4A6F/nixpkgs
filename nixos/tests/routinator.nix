import ./make-test-python.nix (
  { pkgs, lib, ... }:

  {
    name = "routinator";
    meta = {
      maintainers = with lib.maintainers; [ _0x4A6F hexa ];
    };

    nodes =
      {

        local_routinator = { pkgs, lib, ... }:
          {
            services.routinator = {
              enable = true;
            };
          };

      };

    testScript = ''
      start_all()
      local_routinator.wait_for_unit("network-online.target")
      #local_routinator.wait_for_unit("routinator.service")
    '';
  }
)
#  curl -s -L "127.0.0.1:9556/validity?asn=12654&prefix=93.175.147.0/24"
