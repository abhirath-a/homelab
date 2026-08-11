{ self, inputs, ... }: {
  flake.nixosModules.sops =
    { config, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        defaultSopsFile = ../../secrets/secrets.yaml;
        secrets = {
          "vaultwarden/secrets" = {
            sopsFile = ../../secrets/vaultwarden.env;
            format = "dotenv";
          };
          "miniflux/secrets" = {
            sopsFile = ../../secrets/miniflux.env;
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
        };
        templates."searxng-env".content = ''
          SEARXNG_SECRET=${config.sops.placeholder."searxng_secret_key"}
        '';
      };
    };
}
