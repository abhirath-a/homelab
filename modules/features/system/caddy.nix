{
  flake.nixosModules.caddy = { pkgs, config, ... }: {
    services.caddy = {
      enable = true;
      package = pkgs.caddy.withPlugins {
        plugins = [ "github.com/caddy-dns/cloudflare@v0.2.4" ];

        hash = "";
      };

      environmentFile = config.sops.templates."caddy.env".path;
      globalConfig = ''
        acme_dns cloudflare {env.CLOUDFLARE_API_TOKEN}
      '';
      virtualHosts = {
        "glance.home.abhirath.net".extraConfig = ''
          reverse_proxy 127.0.0.1:8080
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
      };
    };

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
