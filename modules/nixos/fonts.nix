{ config, lib, pkgs, ... }:

{
  fonts = {
    fonts = with pkgs; [
      emacs-all-the-icons-fonts
      hack-font
      roboto
      roboto-mono
      material-design-icons
      ibm-plex
      nerdfonts
      dejavu_fonts
      liberation_ttf
      roboto
      fira-code
      fira-code-symbols
      jetbrains-mono
      siji
      font-awesome
      cascadia-code
    ];
  };
}
