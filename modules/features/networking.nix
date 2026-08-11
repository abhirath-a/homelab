{ self, inputs, ... }: {
  flake.nixosModules.networking = {
    networking = {
      hostName = "sherbet";
      firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          80
          443
        ];
        allowedUDPPorts = [ 41641 ];
      };
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
    };

    programs.mosh.enable = true;

    services.tailscale = {
      enable = true;
      useRoutingFeatures = "both";
      permitCertUid = "caddy";
    };

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
