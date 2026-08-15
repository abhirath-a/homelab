{
  flake.nixosModules.networking = { pkgs, ... }: {

    environment.systemPackages = with pkgs; [
      btop
      git
      tmux
    ];

    networking = {
      firewall = {
        enable = true;
        allowedTCPPorts = [
          22
          80
          443
          53
          5380
          53443
        ];
        allowedUDPPorts = [
          41641
          53
        ];
      };
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };

      interfaces = {
        wlp2s0 = {
          allowedTCPPorts = [ 53 ];
          allowedUDPPorts = [ 53 ];
        };
        wg0 = {
          allowedTCPPorts = [
            53
            5380
            22
            53443
          ];
          allowedUDPPorts = [ 53 ];
        };
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
