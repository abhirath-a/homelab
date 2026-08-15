{
  flake.nixosModules.technitium = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.nss ];

    services.technitium-dns-server = {
      enable = true;
      openFirewall = true;
    };
  };
}
