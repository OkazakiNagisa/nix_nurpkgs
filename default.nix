{
  pkgs ? import <nixpkgs> { },
}:

(import ./dependencies/flake-compat-ff81ac966bb2cae68946d5ed5fc4994f96d0ffec { src = ./.; }).outputs.legacyPackages.${pkgs.stdenv.system}