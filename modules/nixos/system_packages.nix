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
    libgcc
    libgccjit
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
    libgcc
    libgccjit
    lm_sensors
    pkg-config
    pciutils
    stdenv.cc.cc.lib
    teamviewer
    plymouth
    gnomeExtensions.appindicator
    gnomeExtensions.mpris-label
    gnomeExtensions.no-activities-button
    steam
  ];
}
