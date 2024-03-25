{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;

      perSystem = { pkgs, ... }:
        {
          devShells.default = pkgs.mkShell
            {
              name = "UGent Typst Template";
              nativeBuildInputs = with pkgs; [ typst just ];
            };


          formatter = pkgs.nixpkgs-fmt;
        };
    };
}
