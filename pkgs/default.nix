# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  plymouth-theme-hud = pkgs.callPackage ./plymouth-theme-hud { };
  pop-launcher = pkgs.callPackage ./pop-launcher { };
}
