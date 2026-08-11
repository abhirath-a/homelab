# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/os/sops.nix
    ../../modules/os/networking.nix
    ../../modules/os/tailscale.nix
    ../../modules/server/glance.nix
    ../../modules/server/miniflux.nix
    ../../modules/server/navidrome.nix
    # ../../modules/server/invidious.nix
    ../../modules/server/searxng.nix
    ../../modules/server/vaultwarden.nix
    # ../../modules/server/dns.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sherbet"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  networking.networkmanager.dns = "systemd-resolved";
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.abhi = {
    isNormalUser = true;
    description = "abhirath agasanakoppa";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBzMufGfgPadH4VlS26zDtY+yKaSfuMd/iWI/0C7+tMe hello@abhirath.net"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEmV+nQ3CHocuzM3L8AS8FEWYLEt6JeoGJ+OKrbtgss #SSH ID - @abhirath"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMxNbYLgowDjv0Nz/gvxfP/oTECyuFqU0m27OvtZaiboSm3dnf2Lps9yUQAsgWUls5Gu1ijDSQjMHBIY2s8pQTk= #SSH ID - @abhirath"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIzsAiIp0B2m2W6gNwQgnDla3RNNCVLvnblP/ull3uNw arun@DESKTOP-NIL5T2N"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDZ1KTPya0xcIat9G+RkNiXvVMeVoR4Qr+4abhUrKIyI abhi@latitude-wsl"
    ];
  };
# networking.firewall.allowedUDPPortRanges = [
#   { from = 6000; to = 6100; }
# ];
  programs.mosh.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false; # Set to false later if using SSH keys
      PermitRootLogin = "no";        # "yes", "no", or "prohibit-password"
    };
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
  services.cloudflared = {
    enable = true;

    tunnels = {
      "41650a73-b754-4742-9c4d-4b86c7885cb5" = {
        credentialsFile = "${config.sops.secrets."cloudflare_website".path}";
        default = "http_status:404";
      };
    };
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "25.05"; # check documentation before changing
}
