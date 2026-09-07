{
  flake.nixosModules.caddy = { pkgs, config, ... }: {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];

        hash = "sha256-7GoH8YLCoPmPExQxoga2FHB58zQDoZVf1BBwkVi0SsQ=";
      };

      environmentFile = config.sops.templates."caddy.env".path;
      globalConfig = ''
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';
      virtualHosts = {
        "glance.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:8081
        '';
        "miniflux.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:8082
        '';
        "navidrome.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:4533
        '';
        "searxng.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:8888
        '';
        "vaultwarden.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:6767
        '';
        "dns.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:5380
        '';
        "stirling.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:8080
        '';
      };
    };
  };
}
