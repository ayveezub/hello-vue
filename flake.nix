{
  description = "hello-vue";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.nodejs_20
        ];
      };

      packages.default = pkgs.buildNpmPackage {
        name = "hello-vue";

        buildInputs = with pkgs; [
          nodejs_20
        ];

        src = self;

        npmDepsHash = "sha256-dV+9v1JYl1eP7ZAMnc/fLOFyHSSBvVJ34qjCowaE2BY=";

        npmBuild = "npm run build";

        installPhase = ''
          mkdir $out
          cp -r dist/* $out/
        '';
      };
    });
}
