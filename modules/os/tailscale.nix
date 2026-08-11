{
	services.tailscale = {
		enable = true; 
		useRoutingFeatures = "both";
    permitCertUid = "caddy";
	};

	networking.firewall.allowedUDPPorts = [41641];
}
