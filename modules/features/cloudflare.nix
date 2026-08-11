{ self, inputs, ... }: {
  flake.nixosModules.cloudflare =
    { config, ... }:
    {
      services.cloudflared = {
        enable = true;

        tunnels = {
          "41650a73-b754-4742-9c4d-4b86c7885cb5" = {
            credentialsFile = "${config.sops.secrets."cloudflare_website".path}";
            default = "http_status:404";
          };
        };
      };
    };
}
