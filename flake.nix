{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    devshell.url = "github:numtide/devshell";
    nix-colors.url = "github:misterio77/nix-colors";

    # hyprland
    hyprland.url = "github:hyprwm/hyprland/v0.19.2beta";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
  };

  outputs = { self, nixpkgs, nixpkgs-master, nixpkgs-unstable, home-manager
    , hardware, emacs-overlay, devshell, ... }@inputs:
    let
      inherit (self) outputs;
      # forAllSystems = nixpkgs.lib.genAttrs [ "aarch64-linux" "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
    in {
      channels.master.input = nixpkgs-master;
      channels.nixpkgs.overlaysBuilder = channels:
        [ (final: prev: { inherit (channels) master; }) ];

      channelsConfig = {
        allowBroken = true;
        allowUnfree = true;
      };

      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays;

      packages = forEachPkgs (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachPkgs (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations = {
        # TODO: rename this host
        # XPS 15 9520
        # Processor: 12th Gen Intel i7-12700H
        # NVIDIA GeForce RTX 3050 Mobile
        # 64GB, 2T SSD
        Niflheim = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos/configuration.nix
            # TODO: add gnome and hyprland each file
          ];
        };
      };

      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "hudson@Niflheim" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home-manager/home.nix ];
        };
      };

      nixConfig = {
        extra-substituters =
          [ "https://hyprland.cachix.org" "https://nix-community.cachix.org" ];
        extra-trusted-public-keys = [
          "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
}
