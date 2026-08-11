{ self, inputs, ... }: {
  flake.nixosModules.sherbetConfig =
    {
      config,
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.sherbetHardware
        # ./hardware-configuration.nix
        # ../../modules/os/sops.nix
        # ../../modules/os/networking.nix
        # ../../modules/os/tailscale.nix
        # ../../modules/server/glance.nix
        # ../../modules/server/miniflux.nix
        # ../../modules/server/navidrome.nix
        # # ../../modules/server/invidious.nix
        # ../../modules/server/searxng.nix
        # ../../modules/server/vaultwarden.nix
        # # ../../modules/server/dns.nix
      ];

      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      time.timeZone = "America/New_York";

      i18n.defaultLocale = "en_US.UTF-8";

      users.users.abhi = {
        isNormalUser = true;
        description = "abhirath agasanakoppa";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzMufGfgPadH4VlS26zDtY+yKaSfuMd/iWI/0C7+tMe hello@abhirath.net"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEmV+nQ3CHocuzM3L8AS8FEWYLEt6JeoGJ+OKrbtgss #SSH ID - @abhirath"
          "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMxNbYLgowDjv0Nz/gvxfP/oTECyuFqU0m27OvtZaiboSm3dnf2Lps9yUQAsgWUls5Gu1ijDSQjMHBIY2s8pQTk= #SSH ID - @abhirath"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzsAiIp0B2m2W6gNwQgnDla3RNNCVLvnblP/ull3uNw arun@DESKTOP-NIL5T2N"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZ1KTPya0xcIat9G+RkNiXvVMeVoR4Qr+4abhUrKIyI abhi@latitude-wsl"
        ];
      };


      services.getty.autologinUser = "abhi";

      nixpkgs.config.allowUnfree = true;

      services.logind.settings.Login.HandleLidSwitch = "ignore";

      environment.systemPackages = with pkgs; [
        neovim
        btop
        fzf
        ripgrep
        git
        yt-dlp
        tmux
        nss
        vim
        age
        sops
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      system.stateVersion = "25.05"; # check documentation before changing
    };
}
