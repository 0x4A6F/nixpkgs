import ./make-test-python.nix (
  { pkgs, lib, ... }:

    {
      name = "sourcehut";

      meta.maintainers = with lib.maintainers; [ _0x4A6F ];

      nodes = {
        sourcehut_client = {};
        sourcehut_server = {
          networking.firewall.allowedTCPPorts = [ 80 443 ];

          services.nginx = {
            enable = true;
            recommendedTlsSettings = true;
            recommendedOptimisation = true;
            recommendedGzipSettings = true;
            recommendedProxySettings = true;
          };

          services.sourcehut.enable = true;
          services.sourcehut.settings = {
            "sr.ht".site-name = "sourcehut";
            "sr.ht".site-info = "sourcehut_server";
            "sr.ht".site-blurb = "\"the hacker's forge\"";
            "sr.ht".environment = "testing";
            "sr.ht".owner-name = "Jane Doe";
            "sr.ht".owner-email = "";
            # nix-shell -p pwgen --run 'pwgen 32'
            "sr.ht".secret-key = "eepaicophefaheolaepie1feeShoo0sa";
            # nix-shell -p sourcehut.metasrht --run 'srht-webhook-keygen'
            webhooks.private-key = "eepaicophefaheolaepie1feeShoo0sa333333333333";

            "git.sr.ht".origin = "";
            "hg.sr.ht".origin = "";
            "man.sr.ht".origin = "";
            "paste.sr.ht".origin = "";
            "todo.sr.ht".origin = "";
            "meta.sr.ht".origin = "";

            # After setting up meta.sr.ht and registering yourself a user account, you can give that account admin permissions:
            # $ python3
            # from metasrht.app import db, User, UserType
            # u = User.query.filter_by(username='[your username]').one()
            # u.user_type = UserType.admin
            # User.query.session.commit()
            "meta.sr.ht::settings".registration = "yes";

            # Specify OAuth keys for other services here
            "git.sr.ht".oauth-client-id = "";
            "git.sr.ht".oauth-client-secret = "";
            "hg.sr.ht".oauth-client-id = "";
            "hg.sr.ht".oauth-client-secret = "";
            "man.sr.ht".oauth-client-id = "";
            "man.sr.ht".oauth-client-secret = "";
            "paste.sr.ht".oauth-client-id = "";
            "paste.sr.ht".oauth-client-secret = "";
            "todo.sr.ht".oauth-client-id = "";
            "todo.sr.ht".oauth-client-secret = "";

            # Optional builds.sr.ht integration
            # "builds.sr.ht".origin = "http://buildsrht.local";
            # "builds.sr.ht".oauth-client-id = "CHANGEME";

            "meta.sr.ht::settings".user-invites = 0;
            "meta.sr.ht::settings".onboarding-redirect = "";

            # Patchset preparation
            "git.sr.ht".outgoing-domain = "example.local";
          };
        };
      };

      testScript = ''
        start_all()

        with subtest("sr.ht default"):
            sourcehut_server.wait_for_unit("multi-user.target")
            sourcehut_server.wait_for_unit("sourcehut.service")
            sourcehut_server.wait_for_open_port(80)
            sourcehut_server.succeed("curl --fail http://localhost:80/")
            sourcehut_server.succeed(
                "curl -s --fail --location http://localhost:80/ | grep -qi sourcehut"
            )
      '';
    }
)
