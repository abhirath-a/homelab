{
  virtualisation.oci-containers.containers.navidrome = {
    image = "deluan/navidrome:latest";
    ports = ["4533:4533"];
    user = "1000:100";
    volumes = [
      "/srv/navidrome/data:/data"
      "/srv/navidrome/music:/music:ro"
    ];
    environment = {
      ND_SCANSCHEDULE = "1h";
      ND_LOGLEVEL = "info";
      ND_SESSIONTIMEOUT = "24h";
      ND_BASEURL = "/";
    };
    autoStart = true;
  };
}
