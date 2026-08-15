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
          BASE_URL = "https://miniflux.tail003e53.ts.net/";
        };
        adminCredentialsFile = config.sops.secrets."miniflux/secrets".path;
      };
    };
}
