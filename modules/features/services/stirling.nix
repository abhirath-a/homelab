{ config, pkgs, ... }:

{
  flake.nixosModules.stirling = {
    virtualisation.oci-containers.containers.stirling-pdf = {
      image = "docker.stirlingpdf.com/stirlingtools/stirling-pdf:latest";
      autoStart = true;
      ports = [
        "8081:8080"
      ];
      volumes = [
        "/srv/stirling:/configs"
      ];
    };
  };
}
