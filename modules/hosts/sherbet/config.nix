{
  flake.nixosModules.sherbetConfig = {
    networking.hostname = "sherbet";
    system.stateVersion = "25.05";
  };
}
