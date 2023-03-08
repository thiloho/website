{
  description = "NodeJS development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nodejs
          prefetch-npm-deps
        ];
      };
      packages.${system}.default = pkgs.buildNpmPackage {
        name = "generate";

        src = ./.;
        npmDepsHash = "sha256-/F5fp+TUz1PHxkGSe5Tsw4dT09hurgH6Z6D3S1vK4vA=";

        installPhase = ''
          mkdir $out
          cp -r ./dist/* $out
        '';
      };
    };
}
