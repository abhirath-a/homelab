{
	networking = {
		hostName = "sherbet";
		firewall = {
			enable = true;
			allowedTCPPorts = [ 22 80 443 ];
		};
		networkmanager.enable = true;
	};
	services.openssh.enable = true;
}
