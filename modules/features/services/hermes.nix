
{ inputs, ... }:
{
  flake.nixosModules.hermes = { config,pkgs, ... }: {
    imports = [
      inputs.hermes-agent.nixosModules.default
    ];
    programs.nix-ld = {
      enable=true;
libraries = with pkgs; [
      stdenv.cc.cc
      glib
      nspr
      nss
      atk
      at-spi2-atk
      at-spi2-core
      dbus
      cups
      expat
      alsa-lib
      systemd

      libx11
      libxcb
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxkbcommon

      libgbm
      libdrm
      libGL
      wayland
      vulkan-loader

      cairo
      pango
      gtk3
      fontconfig
      freetype
    ];
    };
    environment.systemPackages = [ pkgs.chromium ];
    virtualisation = {
      podman.enable = true;
      docker.enable = false;
    };

    services.hermes-agent = {
      enable = true;
      addToSystemPackages = true;

      container = {
        enable = true;
        backend = "podman";
        image = "docker.io/library/ubuntu:24.04";
        hostUsers = [ "abhi" ];
      };

      extraDependencyGroups = [ "messaging" ];

      settings = {
        model = {
          provider = "openai-codex";
          default = "gpt-6.1-sol";
        };
        agent = {
          reasoning_effort = "low";
          text_verbosity = "low";
        };
        toolsets = [ "all" ];

        terminal = {
          backend = "local";
          timeout = 180;
        };

        memory = {
          memory_enabled = true;
          user_profile_enabled = true;
        };
        discord = {
          require_mention = true;
          reactions = true;
        };
      };

      environmentFiles = [
        config.sops.secrets."hermes-env".path
      ];
    };
  };
}

