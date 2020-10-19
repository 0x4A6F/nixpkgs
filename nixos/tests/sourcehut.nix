import ./make-test-python.nix (
  { pkgs, lib, ... }:

    {
      name = "sourcehut";

      meta.maintainers = with lib.maintainers; [ _0x4A6F ];

      nodes = {
        sourcehut_server = {
          networking.firewall.allowedTCPPorts = [ 80 443 ];

          services.nginx = {
            enable = true;
            recommendedTlsSettings = true;
            recommendedOptimisation = true;
            recommendedGzipSettings = true;
            recommendedProxySettings = true;
          };

          services.postgresql = {
             enable = true;
             ensureDatabases = [ "sourcehut" ];
             ensureUsers = [
               { name = "sourcehut";
                 ensurePermissions."DATABASE sourcehut" = "ALL PRIVILEGES";
               }
             ];
           };

          services.sourcehut.enable = true;
          services.sourcehut.settings = {
            # The name of your network of sr.ht-based sites
            "sr.ht".site-name = "sourcehut";

            # The top-level info page for your site
            "sr.ht".site-info = "sourcehut_server";

            # {{ site-name }}, {{ site-blurb }}
            "sr.ht".site-blurb = "\"the hacker's forge\"";

            # If this != production, we add a banner to each page
            "sr.ht".environment = "testing";

            # Contact information for the site owners
            "sr.ht".owner-name = "Jane Doe";
            "sr.ht".owner-email = "mail@example.org";

            # The source code for your fork of sr.ht
            "sr.ht".source-url = "https://git.sr.ht/~sircmpwn/srht";

            # A secret key to encrypt session cookies with
            # nix-shell -p pwgen --run 'pwgen 32'
            "sr.ht".secret-key = "eepaicophefaheolaepie1feeShoo0sa";

            # base64-encoded Ed25519 key for signing webhook payloads. This should be
            # consistent for all *.sr.ht sites, as we'll use this key to verify signatures
            # from other sites in your network.
            #
            # Use the srht-webhook-keygen command to generate a key.
            # nix-shell -p sourcehut.metasrht --run 'srht-webhook-keygen'
            # Private key: rBSCsdozjxm257U5ib0ZZr6wvrLUVk6gUjgyR/USrEg=
            # Public key: o7AGAi/66bhc5usAe20uu24Ffi052DplRanIB+rI3Zo=
            webhooks.private-key = "rBSCsdozjxm257U5ib0ZZr6wvrLUVk6gUjgyR/USrEg=";

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
            "git.sr.ht".outgoing-domain = "example.org";
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
