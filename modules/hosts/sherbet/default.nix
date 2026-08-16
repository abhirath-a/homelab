{ self, inputs, ... }: {
  flake.nixosConfigurations.sherbet = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      sherbetHardware
      sherbetConfig
      boot
      ddns
      networking
      pkgs
      sops
      user
      glance
      miniflux
      navidrome
      searxng
      technitium
      vaultwarden
      wireguard
      caddy
    ];
  };
}
