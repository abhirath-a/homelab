{ self, inputs, ... }: {
  flake.nixosModules.technitium = { config, ... }: {
    services.technitium-dns-server = {
      enable = true;

      openFirewall = true;
    };

    networking.firewall = {
# DNS from the LAN and WireGuard networks. 
      interfaces = { 
        wlp2s0 = { allowedTCPPorts = [ 53 ]; allowedUDPPorts = [ 53 ]; }; 
        wg0 = { allowedTCPPorts = [ 53 5380 22 53443]; allowedUDPPorts = [ 53 ]; }; 
      }; 
    };
  };

}
