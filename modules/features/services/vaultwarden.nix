{
  flake.nixosModules.vaultwarden =
    { config, ... }:
    {
      services.vaultwarden = {
        enable = true;
        backupDir = "/var/local/vaultwarden/backup";
        environmentFile = config.sops.secrets."vaultwarden/secrets".path;
        config = {
          DOMAIN = "https://vaultwarden.home.abhirath.net";
          SIGNUPS_ALLOWED = false;
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 6767;
          ROCKET_LOG = "critical";
        };
      };
    };
}
