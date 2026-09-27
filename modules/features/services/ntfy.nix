{
  flake.nixosModules.ntfy = {
      services.ntfy-sh = {
        enable = true;
        settings = {
          base-url = "https://ntfy.home.abhirath.net";
          upstream-base-url = "https://ntfy.sh";
          listen-http = ":4141"; 
        };
      };
  };
}
