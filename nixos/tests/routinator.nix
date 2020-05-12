
import ./make-test-python.nix ({ pkgs, lib, ...} : {
  name = "routinator";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ maintainers."0x4A6F" hexa ];
  };

  nodes =
    {

      local_routinator = { pkgs, lib, ... }:
      {
        services.routinator = {
          enable = true;
          extraConfig = ''
          '';
        };
      };

    };

  testScript =
    ''
      start_all()

      local_routinator.wait_for_unit("network-online.target")

      local_routinator.wait_for_unit("routinator_init.service")
    '';
})
#  curl -s -L "127.0.0.1:9556/validity?asn=12654&prefix=93.175.147.0/24"
