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
        packages = [ pkgs.nodejs ];
      };
      packages.${system}.default = pkgs.buildNpmPackage {
        name = "generate";

        src = ./.;
        npmDepsHash = "sha256-Hoo5dfOkTm4DMnJgB88vhyXUrLrB+rkVKgW+O8TqtQQ=";

        installPhase = ''
          mkdir $out
          cp -r ./dist/* $out
        '';
      };
    };
}
