{ self, inputs, ... }: {
  flake.nixosModules.glance = {
    virtualisation.oci-containers.containers.glance = {
      image = "glanceapp/glance:latest";
      ports = [ "8080:8080" ];
      volumes = [ "/var/lib/glance/config:/app/config" ];
      environment = {
        GLANCE_PORT = "8080";
      };
    };
  };
}
