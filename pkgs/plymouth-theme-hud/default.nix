{ stdenv, logo ? null, lib, ... }:
stdenv.mkDerivation {
  pname = "plymouth-theme-hud";
  version = "1.0";
  src = ./src;

  buildPhase = lib.optionalString (logo != null) ''
    cp $src . -r
    ln -s ${logo} ./share/plymouth/themes/hud_3/watermark.png
  '';

  installPhase = ''
    cp -r . $out
  '';

  meta = { platforms = lib.platforms.all; };
}
