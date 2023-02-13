# { stdenv, logo ? null, lib, ... }:
# stdenv.mkDerivation {
#   pname = "plymouth-theme-hud";
#   version = "1.0";
#   src = ./src;

#   buildPhase = lib.optionalString (logo != null) ''
#     cp $src . -r
#     ln -s ${logo} ./share/plymouth/themes/hud_3/watermark.png
#   '';

#   installPhase = ''
#     cp -r . $out
#   '';

#   meta = { platforms = lib.platforms.all; };
# }
{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation rec {
  # pname = "adi1090x-plymouth";
  pname = "plymouth-theme-hud";
  version = "0.0.1";

  src = builtins.fetchGit {
    url = "https://github.com/adi1090x/plymouth-themes";
    rev = "bf2f570bee8e84c5c20caac353cbe1d811a4745f";
  };

  buildInputs = [ pkgs.git ];

  configurePhase = ''
    mkdir -p $out/share/plymouth/themes/
  '';

  buildPhase = "";

  installPhase = ''
    cp -r pack_3/hud_3 $out/share/plymouth/themes
    cat pack_3/hud_3/hud_3.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/hud_3/hud_3.plymouth
  '';
}
