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
