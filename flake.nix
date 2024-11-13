{
  inputs = {
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs:
    inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        nixpkgsArgs = {
          inherit system;
          config = { };
        };
        nixpkgs-24-05 = import inputs.nixpkgs-24-05 nixpkgsArgs;
        nixpkgs-unstable = import inputs.nixpkgs-unstable nixpkgsArgs;
      in
      rec {
        packages = {
          nodejs = nixpkgs-24-05.nodejs_22;
          deno = nixpkgs-unstable.deno;
          bun = nixpkgs-24-05.bun;
          typescript = nixpkgs-24-05.typescript;
        };
        devShells.default = nixpkgs-24-05.mkShell {
          name = "bun-deno-node-playground";
          buildInputs = with packages; [
            nodejs
            deno
            bun
            typescript
          ];
        };
      }
    );
}
