{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.routinator;

  conditionalBoolToString = value: if (isBool value) then (boolToString value) else (toString value);

  paramsString = params:
    concatMapStringsSep " " (name: "${name} ${conditionalBoolToString (getAttr name params)}")
                   (attrNames params);

  interfaceConfig = name:
    let
      interface = getAttr name cfg.interfaces;
    in
    "interface ${name} ${paramsString interface}\n";

  configFile = with cfg; pkgs.writeText "routinator.conf" (
    (optionalString (cfg.interfaceDefaults != null) ''
      default ${paramsString cfg.interfaceDefaults}
    '')
    + (concatMapStrings interfaceConfig (attrNames cfg.interfaces))
    + extraConfig);

in

{

  ###### interface

  options = {

    services.routinator = {

      enable = mkEnableOption "the routinator RPKI validator daemon";

      baseDir = mkOption {
        type = types.str;
        default = "/var/lib/routinator";
        description = ''
          The base directory where routinator stores its persistent data.
        '';
      };

      interfaceDefaults = mkOption {
        default = null;
        description = ''
          A set describing default parameters for routinator interfaces.
          See <citerefentry><refentrytitle>routinator</refentrytitle><manvolnum>8</manvolnum></citerefentry> for options.
        '';
        type = types.nullOr (types.attrsOf types.unspecified);
        example =
          {
            type = "tunnel";
            split-horizon = true;
          };
      };

      interfaces = mkOption {
        default = {};
        description = ''
          A set describing routinator interfaces.
          See <citerefentry><refentrytitle>routinator</refentrytitle><manvolnum>8</manvolnum></citerefentry> for options.
        '';
        type = types.attrsOf (types.attrsOf types.unspecified);
        example =
          { enp0s2 =
            { type = "wired";
              hello-interval = 5;
              split-horizon = "auto";
            };
          };
      };

      extraConfig = mkOption {
        default = "";
        description = ''
          Options that will be copied to routinator.conf.
          See <citerefentry><refentrytitle>routinator</refentrytitle><manvolnum>8</manvolnum></citerefentry> for details.
        '';
      };
    };

  };


  ###### implementation

  config = mkIf config.services.routinator.enable {

    users.users.routinator = {
      description = "routinator server user";
      group = "routinator";
      uid = config.ids.uids.routinator;
    };

    users.groups.routinator.gid = config.ids.gids.routinator;

    systemd.services.routinator_init = {
      wantedBy = [ "routinator.service" ];
      partOf = [ "routinator.service" ];
      before = [ "routinator.service" ];
      serviceConfig = {
        User = "routinator";
        Group = "routinator";
        WorkingDirectory = "/var/lib/routinator";
        Type = "oneshot";
      };
      script = ''
        mkdir -p /var/lib/routinator
        chown -R routinator /var/lib/routinator
        ${pkgs.routinator}/bin/routinator --base-dir=/var/lib/routinator init --force --accept-arin-rpa
      '';
    };

    systemd.services.routinator = {
      description = "RPKI validator daemon";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig.ExecStart = "${pkgs.routinator}/bin/routinator --base-dir=/var/lib/routinator  server --rtr 127.0.0.1:3323 --http 127.0.0.1:9556";
    # serviceConfig.ExecStart = "${pkgs.routinator}/bin/routinator server --config ${configFile}";
      serviceConfig = {
        User = "routinator";
        Group = "routinator";
        WorkingDirectory = "routinator";
      #  DynamicUser = "yes";
        RuntimeDirectory = "routinator";
        StateDirectory = "routinator";
        CacheDirectory = "routinator";
        LogsDirectory = "routinator";
        ConfigurationDirectory = "routinator";
      #  StateDirectoryMode = "0700";
      #  PrivateDevices = true;
      #  # Sandboxing
      #  CapabilityBoundingSet = "CAP_NET_RAW CAP_NET_ADMIN";
      #  ProtectSystem = "strict";
      #  ProtectHome = true;
      #  PrivateTmp = true;
      #  ProtectKernelTunables = true;
      #  ProtectKernelModules = true;
      #  ProtectControlGroups = true;
      #  RestrictAddressFamilies = "AF_INET AF_INET6 AF_UNIX AF_PACKET AF_NETLINK";
      #  RestrictNamespaces = true;
      #  LockPersonality = true;
      #  MemoryDenyWriteExecute = true;
      #  RestrictRealtime = true;
      #  RestrictSUIDSGID = true;
      };
    };

  };

}
