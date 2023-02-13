# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ inputs, outputs, lib, config, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example
    outputs.nixosModules.system_packages
    outputs.nixosModules.fonts

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd
    inputs.hardware.nixosModules.dell-xps-15-9500

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.additions

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      allowBroken = true;
    };
  };

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
      config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking.hostName = "Niflheim";

  # Use the grub
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    device = "nodev";
  };

  # setup luks
  boot.initrd.luks.devices = {
    crypted = {
      device = "/dev/disk/by-uuid/92d84092-65a1-4de0-b837-5bdb2543c06a";
      preLVM = true;
    };
  };

  # disable some logs on boot
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  # kernel params
  boot.kernelParams = [
    "loglevel=3"
    "quiet"
    "nouveau.modeset=0"
    "ibt=off"
    "vt.global_cursor_default=0"
  ];

  # plymouth config
  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    enable = true;
    theme = "hud_3";
    themePackages = [
      (pkgs.plymouth-theme-hud.override {
        inherit (config.boot.plymouth) logo;
      })
    ];
  };

  # user group config
  users.users = {
    hudson = {
      description = "Hudson Couto";
      createHome = true;
      home = "/home/hudson";
      isNormalUser = true;
      shell = pkgs.zsh;
      uid = 1000;
      extraGroups = [
        "wheel"
        "networkmanager"
        "adbusers"
        "audio"
        "video"
        "storage"
        "docker"
      ];
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.cpu.intel.updateMicrocode = true;
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    media-session.enable = false;
    wireplumber.enable = true;
  };

  # bluetooth
  hardware.bluetooth = { enable = true; };
  services.blueman.enable = true;

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  # batery life
  powerManagement.powertop.enable = true;

  console = { keyMap = "us-acentos"; };

  # time zone
  time.timeZone = "America/Sao_Paulo";

  # network
  networking.networkmanager.enable = true;

  # nvidia setup
  boot.blacklistedKernelModules = [ "nouveau" "nvidiafb" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    video.hidpi.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      nvidiaSettings = true;
      modesetting.enable = true;
      nvidiaPersistenced = true;

      prime = {
        offload.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };

      powerManagement = {
        enable = true;
        finegrained = true;
      };
    };
  };

  # X11/Gnome config
  services.xserver = {
    enable = true;
    dpi = 110;

    layout = "us";
    xkbVariant = "intl";
    libinput.enable = true;

    displayManager = {
      gdm.enable = true;
      gdm.wayland = false;
      gdm.autoSuspend = false;
    };
    desktopManager.gnome.enable = true;
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    # Forbid root login through SSH.
    permitRootLogin = "no";
    # Use keys only. Remove if you want to SSH using password (not recommended)
    passwordAuthentication = false;
  };

  environment.variables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  };

  # docker
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    enableOnBoot = false;
  };

  # teamviewer
  services.teamviewer.enable = true;

  # steam service config
  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };

  # Steam Proton Config
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
