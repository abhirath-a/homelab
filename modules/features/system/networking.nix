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
        ];
        allowedUDPPorts = [
          53
        ];
      };
      networkmanager = {
        enable = true;
        dns = "systemd-resolved";
      };
    };

    programs.mosh.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}
