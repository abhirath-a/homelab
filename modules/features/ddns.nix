{ self, inputs, ... }: {
  flake.nixosModules.ddns = { config, pkgs, ... }:
  let
    domain = "vpn.example.com";
    zone = "example.com";
  in
  {
    systemd.services.cloudflare-ddns = {
      description = "Update Cloudflare DDNS record";
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];

      serviceConfig = {
        Type = "oneshot";

        EnvironmentFile =
          config.sops.secrets."cloudflare_ddns_api_token".path;
      };

      script = ''
        set -euo pipefail

        TOKEN="$CLOUDFLARE_API_TOKEN"

        CURRENT_IP="$(
            ${pkgs.curl}/bin/curl \
            --fail \
            --silent \
            --show-error \
            https://api.ipify.org
            )"

        ZONE_ID="$(
            ${pkgs.curl}/bin/curl \
            --fail \
            --silent \
            --show-error \
            "https://api.cloudflare.com/client/v4/zones?name=${zone}" \
            -H "Authorization: Bearer $TOKEN" \
            -H "Content-Type: application/json" \
            | ${pkgs.jq}/bin/jq -r '.result[0].id'
            )"

        RECORD_ID="$(
            ${pkgs.curl}/bin/curl \
            --fail \
            --silent \
            --show-error \
            "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=${domain}" \
            -H "Authorization: Bearer $TOKEN" \
            -H "Content-Type: application/json" \
            | ${pkgs.jq}/bin/jq -r '.result[0].id'
            )"

        DNS_IP="$(
            ${pkgs.curl}/bin/curl \
            --fail \
            --silent \
            --show-error \
            "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
            -H "Authorization: Bearer $TOKEN" \
            -H "Content-Type: application/json" \
            | ${pkgs.jq}/bin/jq -r '.result.content'
            )"

        if [ "$CURRENT_IP" = "$DNS_IP" ]; then
          echo "IP unchanged: $CURRENT_IP"
            exit 0
            fi

            echo "Updating ${domain}: $DNS_IP -> $CURRENT_IP"

            ${pkgs.curl}/bin/curl \
            --fail \
            --silent \
            --show-error \
            -X PATCH \
            "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
            -H "Authorization: Bearer $TOKEN" \
            -H "Content-Type: application/json" \
            --data "{
              \"type\": \"A\",
                \"name\": \"${domain}\",
                \"content\": \"$CURRENT_IP\",
                \"ttl\": 120,
                \"proxied\": false
            }"
      '';
    };

    systemd.timers.cloudflare-ddns = {
      description = "Cloudflare DDNS timer";

      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnBootSec = "1min";
        OnUnitActiveSec = "5min";
        Persistent = true;
      };
    };
  };
}
