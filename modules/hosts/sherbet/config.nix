{
  flake.nixosModules.sherbetConfig = {
    networking.hostName = "sherbet";
    system.stateVersion = "25.05";
  };
}
