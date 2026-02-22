{
  description = "NUR package repository by nakido";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-compat.url = "github:NixOS/flake-compat/v1.1.0";
    flake-compat.flake = false;
  };

  outputs =
    { self, ... }@inputs:
    with inputs;
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      lib = import ./lib { inherit (nixpkgs) lib; };

      legacyPackages = forAllSystems (
        system:
        let
          mypkgs = builtins.listToAttrs (
            map (file: {
              name = self.lib.getFilenameNoSuffix file;
              value = nixpkgs.legacyPackages.${system}.callPackage file { };
            }) (self.lib.globPackages ./pkgs)
          );
        in
        mypkgs
        // {
          # The `lib`, `modules`, and `overlays` names are special
          # modules = import ./modules; # NixOS modules
          # overlays = import ./overlays; # nixpkgs overlays
          # example-package = pkgs.callPackage ./pkgs/example-package { };
        }
      );

      packages = forAllSystems (
        system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
      );
    };
}