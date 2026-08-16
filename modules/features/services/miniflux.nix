{
  flake.nixosModules.miniflux =
    { config, ... }:
    {
      services.miniflux = {
        enable = true;
        config = {
          LISTEN_ADDR = "0.0.0.0:8082";
          RUN_MIGRATIONS = 1;
          CREATE_ADMIN = 1;
          BASE_URL = "https://miniflux.home.abhirath.net/";
        };
        adminCredentialsFile = config.sops.secrets."miniflux/secrets".path;
      };
    };
}
