{
  flake.nixosModules.user = {
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
  };
}
