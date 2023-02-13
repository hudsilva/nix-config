{
  pkgs ? import <nixpkgs> {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "adi1090x-plymouth";
  version = "0.0.1";

  src = builtins.fetchGit {
    url = "https://github.com/adi1090x/plymouth-themes";
  };

  buildInputs = [
    pkgs.git
  ];

  configurePhase = ''
mkdir -p $out/share/plymouth/themes/
  '';

  buildPhase = ''
  '';

  installPhase = ''
  cp -r pack_3/lone $out/share/plymouth/themes
  cat pack_3/lone/lone.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/lone/lone.plymouth

  cp -r pack_3/hud_3 $out/share/plymouth/themes
  cat pack_3/hud_3/hud_3.plymouth | sed  "s@\/usr\/@$out\/@" > $out/share/plymouth/themes/hud_3/hud_3.plymouth
  '';
}

