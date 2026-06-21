{
  inputs,
  config,
  ...
}: let
  system = "x86_64-linux";
  pkgsConfig = {
    allowUnfree = true;
    allowInsecure = true;
  };

  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config = pkgsConfig;
  };
  customOverlay = import ./pkgs/default.nix;
  mkSystem = modules:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
        stable = pkgs-stable;
      };
      modules =
        modules
        ++ [
          {
            nixpkgs.hostPlatform = system;
            nixpkgs.config = pkgsConfig;
            nixpkgs.overlays = [
              inputs.helium.overlays.default
              customOverlay
              (final: prev: {
                zen-browser = inputs.zen-browser.packages.${final.stdenv.hostPlatform.system}.default;
              })
            ];
          }
          inputs.disko.nixosModules.disko
          ./nix/disko.nix
          inputs.stylix.nixosModules.stylix
          inputs.nix-index-database.nixosModules.nix-index
          inputs.nix-flatpak.nixosModules.nix-flatpak
          ({pkgs, ...}: {
            environment.systemPackages =
              [inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien]
              ++ (builtins.attrValues (customOverlay pkgs pkgs));
          })
          config.flake.nixosModules.homeLinks
        ];
    };
in {
  flake.nixosConfigurations.mark = mkSystem [./default.nix];
}
