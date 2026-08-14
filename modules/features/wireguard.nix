{ self, inputs, ... }: {
  flake.nixosModules.wireguard ={ config, ... }:
  {
    networking.wg-quick.interfaces.wg0 = {
      address = [
        "10.50.0.1/24"
      ];

      listenPort = 51820;

      privateKeyFile = config.sops.secrets."wireguard_private_key".path;

      peers = [
      {
        # laptop
        publicKey = "qRxkLCrEWejugnUtJFRPepoAIlEU8K5axjvHEFhOIlk=";

        allowedIPs = [
          "10.50.0.2/32"
        ];
      }
      {
        # iPhone
        publicKey = "XZVE3f5g1uRQKqp9nsWOf89MZ8klsqJEv+7tzLyUiDw=";

        allowedIPs = [
          "10.50.0.4/32"
        ];
      }
      ];
    };

    networking.firewall = {
      allowedUDPPorts = [ 51820 ];

      interfaces.wg0 = {
        allowedTCPPorts = [
            22
            53
            5380
            53443
        ];

        allowedUDPPorts = [
          53
        ];
      };
    };
  };
}
