import ./make-test-python.nix (
  { pkgs, lib, ... }:

    {
      name = "xandikos";

      meta.maintainers = with lib.maintainers; [ _0x4A6F ];

      nodes = {
        xandikosClient = {};
        xandikosDefault = {
          networking.firewall.allowedTCPPorts = [ 8080 ];
          services.xandikos.enable = true;
        };
        xandikosProxy = {
          networking.firewall.allowedTCPPorts = [ 80 8080 ];
          services.xandikos.enable = true;
          services.xandikos.address = "localhost";
          services.xandikos.port = 8080;
          services.xandikos.routePrefix = "/xandikos-prefix/";
          services.xandikos.extraOptions = [
            "--defaults"
          ];
          services.nginx = {
            enable = true;
            recommendedProxySettings = true;
            virtualHosts."xandikos" = {
              serverName = "xandikos.local";
              basicAuth.xandikos = "snakeOilPassword";
              locations."/xandikos/" = {
                proxyPass = "http://localhost:8080/xandikos-prefix/";
              };
            };
          };
        };
      };

      testScript = ''
        start_all()

        with subtest("Xandikos default"):
            xandikosDefault.wait_for_unit("multi-user.target")
            xandikosDefault.wait_for_unit("xandikos.service")
            xandikosDefault.wait_for_open_port(8080)
            xandikosDefault.succeed("curl --fail http://localhost:8080/")
            xandikosDefault.succeed(
                "curl -s --fail --location http://localhost:8080/ | grep -i Xandikos"
            )
            xandikosClient.wait_for_unit("network-online.target")
            xandikosClient.fail("curl --fail http://xandikosDefault:8080/")

        with subtest("Xandikos proxy"):
            xandikosProxy.wait_for_unit("multi-user.target")
            xandikosProxy.wait_for_unit("xandikos.service")
            xandikosProxy.wait_for_open_port(8080)
            xandikosProxy.succeed("curl --fail http://localhost:8080/")
            xandikosProxy.succeed(
                "curl -s --fail --location http://localhost:8080/ | grep -i Xandikos"
            )
            xandikosClient.wait_for_unit("network-online.target")
            xandikosClient.fail("curl --fail http://xandikosProxy:8080/")
            xandikosClient.succeed(
                "curl -s --fail -u xandikos:snakeOilPassword -H 'Host: xandikos.local' http://xandikosProxy/xandikos/ | grep -i Xandikos"
            )
            xandikosClient.succeed(
                "curl -s --fail -u xandikos:snakeOilPassword -H 'Host: xandikos.local' http://xandikosProxy/xandikos/user/ | grep -i Xandikos"
            )
      '';
    }
)
