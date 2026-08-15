{ self, inputs, ... }: {
  flake.nixosConfigurations.sherbet = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      sherbetHardware
      sherbetConfig
      ddns
      technitium
      glance
      miniflux
      navidrome
      networking
      searxng
      sops
      vaultwarden
      wireguard
    ];
  };
}
