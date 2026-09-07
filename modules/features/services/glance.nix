{
  flake.nixosModules.glance = {
    virtualisation.oci-containers.containers.glance = {
      image = "glanceapp/glance:latest";
      ports = [ "8081:8081" ];
      volumes = [ "/var/lib/glance/config:/app/config" ];
      environment = {
        GLANCE_PORT = "8081";
      };
    };
  };
}
