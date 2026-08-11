{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "d /srv/invidious 0755 root root -"
    "d /srv/invidious/postgres 0755 root root -"
    "d /srv/invidious/companion 0755 root root -"
  ];

  virtualisation.oci-containers = {
    backend = "podman";

    containers = {

      invidious-db = {
        image = "docker.io/postgres:14";

        autoStart = true;

        volumes = [
          "/srv/invidious/postgres:/var/lib/postgresql/data"
          "/srv/invidious/sql:/config/sql:ro"
          "/srv/invidious/init-invidious-db.sh:/docker-entrypoint-initdb.d/init-invidious-db.sh:ro"
        ];

        environment = {
          POSTGRES_DB = "invidious";
          POSTGRES_USER = "kemal";
          POSTGRES_PASSWORD = "Zah4Xe1phaeya2wo";
        };

        extraOptions = [
          "--network=invidious"
        ];
      };


      invidious-companion = {
        image = "quay.io/invidious/invidious-companion:latest";

        autoStart = true;

        volumes = [
          "/srv/invidious/companion:/var/tmp/youtubei.js"
        ];

        environment = {
          SERVER_SECRET_KEY = "WeiyooK5Yohwee7l";
        };

        extraOptions = [
          "--network=invidious"
        ];
      };


      invidious = {
        image = "quay.io/invidious/invidious:latest";

        autoStart = true;

        ports = [
          "127.0.0.1:3000:3000"
        ];

        volumes = [
          "/srv/invidious/config.yml:/invidious/config/config.yml:ro"
        ];

        extraOptions = [
          "--network=invidious"
        ];

        dependsOn = [
          "invidious-db"
          "invidious-companion"
        ];
      };
    };
  };


  systemd.services.podman-invidious-network = {
    description = "Create Invidious podman network";

    wantedBy = [
      "multi-user.target"
    ];

    before = [
      "podman-invidious.service"
      "podman-invidious-db.service"
      "podman-invidious-companion.service"
    ];

    serviceConfig.Type = "oneshot";

    script = ''
      ${pkgs.podman}/bin/podman network exists invidious || \
      ${pkgs.podman}/bin/podman network create invidious
    '';
  };
}
