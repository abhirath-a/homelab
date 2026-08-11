{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
  };

  # outputs =
  #   {
  #     self,
  #     nixpkgs,
  #     sops-nix,
  #   }@inputs:
  #   let
  #     mySystem = "x86_64-linux";
  #   in
  #   {
  #
  #     nixosConfigurations.sherbet = nixpkgs.lib.nixosSystem {
  #       specialArgs = { inherit inputs; };
  #       system = "${mySystem}";
  #       modules = [
  #         ./hosts/sherbet/configuration.nix
  #       ];
  #     };
  #   };
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
