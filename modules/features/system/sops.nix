{ inputs, ... }: {
  flake.nixosModules.sops =
    { config, pkgs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      environment.systemPackages = with pkgs; [
        age
        sops
      ];

      sops = {
        defaultSopsFile = ../../../secrets/secrets.yaml;
        secrets = {
          "vaultwarden/secrets" = {
            sopsFile = ../../../secrets/vaultwarden.env;
            format = "dotenv";
          };
          "miniflux/secrets" = {
            sopsFile = ../../../secrets/miniflux.env;
            format = "dotenv";
          };
          "searxng_secret_key" = {
            # owner = "searxng";
          };
          "cloudflare_website" = {
            owner = "abhi";
            group = "users";
            mode = "0400";
          };
          "invidious_secret_key" = { };
          "invidious_db_password" = { };
          "wireguard_private_key" = { };
          "cloudflare_api_token" = { };
          "cloudflare_ddns_api_token" = { };
        };

        templates."caddy.env" = {
          content = ''
            CLOUDFLARE_API_TOKEN=${config.sops.placeholder.cloudflare_api_token}
          '';

          mode = "0400";
        };

        templates."searxng-env".content = ''
          SEARXNG_SECRET=${config.sops.placeholder."searxng_secret_key"}
        '';
      };
    };
}
