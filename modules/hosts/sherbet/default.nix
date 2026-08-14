{ self, inputs, ... }: {
  flake.nixosConfigurations.sherbet = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.sherbetConfig
      self.nixosModules.ddns
      self.nixosModules.technitium
      self.nixosModules.glance
      self.nixosModules.miniflux
      self.nixosModules.navidrome
      self.nixosModules.networking
      self.nixosModules.searxng
      self.nixosModules.sops
      self.nixosModules.vaultwarden
      self.nixosModules.wireguard
    ];
  };
}
