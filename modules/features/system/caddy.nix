{
  flake.nixosModules.caddy = { pkgs, config, ... }: {
    services.caddy = {
      enable = true;

      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];
        hash = "sha256-QSiwKqKvSxhksWBF4/MlBOpyXba5xOQ2sRwA0R7399E=";
      };

      environmentFile = config.sops.templates."caddy.env".path;

      globalConfig = ''
        tls_resolvers 1.1.1.1 1.0.0.1
      '';

      virtualHosts =
        let
          tlsConfig = ''
            tls {
              dns cloudflare {env.CLOUDFLARE_API_TOKEN}
              resolvers 1.1.1.1 1.0.0.1
            }
          '';

          proxy = port: ''
            ${tlsConfig}
            reverse_proxy 127.0.0.1:${toString port}
          '';
        in
        {
          "glance.home.abhirath.net".extraConfig = proxy 8080;
          "miniflux.home.abhirath.net".extraConfig = proxy 8082;
          "ntfy.home.abhirath.net".extraConfig = proxy 4141;
          "navidrome.home.abhirath.net".extraConfig = proxy 4533;
          "searxng.home.abhirath.net".extraConfig = proxy 8888;
          "vaultwarden.home.abhirath.net".extraConfig = proxy 6767;
          "dns.home.abhirath.net".extraConfig = proxy 5380;
          "stirling.home.abhirath.net".extraConfig = proxy 8081;
        };
    };
  };
}
