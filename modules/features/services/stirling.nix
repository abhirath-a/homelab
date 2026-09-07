{
  flake.nixosModules.stirling = {
    services.stirling-pdf = {
      enable = true;
      port = 8081;
    };
  };
}
