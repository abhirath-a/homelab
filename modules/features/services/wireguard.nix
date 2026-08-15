{
  flake.nixosModules.wireguard =
    { config, ... }:
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
          {
            # desktop
            publicKey = "HL9kzTATxLIAeSet45HsuZVweXF0/6JV5vdfw4MYv1k=";

            allowedIPs = [
              "10.50.0.3/32"
            ];
          }
        ];
      };
    };
}
