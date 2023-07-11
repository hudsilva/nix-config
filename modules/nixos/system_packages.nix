{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    bc
    bind
    binutils
    cached-nix-shell
    cachix
    coreutils
    clang
    curl
    dmidecode
    entr
    exa
    gcc
    gnumake
    git
    file
    htop
    libsecret
    # libgcc
    # libgccjit
    i7z
    iw
    jq
    lm_sensors
    netcat
    nix-index
    nix-tree
    openssl
    pciutils
    patchelf
    simple-http-server
    tree
    unzip
    wget
    xclip
    zlib

    # nvtop-nvidia
    # nvidia-offload
    bluez
    bluez-tools
    bluez-alsa
    blueman
    libsmbios
    powertop
    vim
    binutils
    libsecret
    gcc.cc.libgcc
    # libgcc
    # libgccjit
    lm_sensors
    pkg-config
    pciutils
    stdenv.cc.cc.lib
    teamviewer
    # plymouth
    steam

    # gnome config
    nodePackages_latest.typescript
    gnome.gnome-shell-extensions
    # gnomeExtensions.appindicator
    gnomeExtensions.pop-shell
    libnotify
    dconf
    font-manager
    gnome3.adwaita-icon-theme
    gnome.gnome-tweaks

    # gnome extensions
    # gnomeExtensions.appindicator
    # gnomeExtensions.mpris-label
    # gnomeExtensions.no-activities-button
    # gnomeExtensions.caffeine

    # pop-launcher
    pop-launcher

    libGL
    libappindicator-gtk3
    libdrm
    # libnotify
    # libpulseaudio
    # libuuid
    # libusb1
    # lshw
    # xorg.libxcb
    libxkbcommon
    mesa
    # nspr
    # nss
    # pango
    pipewire
    systemd
    icu
    xorg.libX11
    xorg.libXScrnSaver
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxkbfile
    xorg.libxshmfence
  ];
}
