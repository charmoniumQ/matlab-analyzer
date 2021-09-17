{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    antlr4-python-grun.url = "github:charmoniumQ/antlr4-python-grun";
  };
  outputs = { self, nixpkgs, flake-utils, antlr4-python-grun }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        name = "matlab-grammar";
      in
      rec {
        # packages.${name} = { };
        # defaultPackage = packages.${name};
        # apps.${name} = flake-utils.lib.mkApp { drv = packages.${name}; };
        # defaultApp = apps.${name};
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.python39
            pkgs.python39Packages.pytest
            pkgs.python39Packages.pytest-expect
            pkgs.pipenv
            # antlr4-python-grun
            pkgs.antlr4
            pkgs.jdk8
          ];
        };

      }
    );
}
