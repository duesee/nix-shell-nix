{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        formatter = pkgs.nixfmt-tree;

        devShells = {
          default = pkgs.mkShell {
            strictDeps = true;
            nativeBuildInputs = with pkgs; [
              # Nix
              deadnix
              nixd
              nix-diff
              nixfmt
              nixos-rebuild
              statix

              # Bash
              shellcheck
              shfmt

              # Visual Studio Code (and plugins)
              (vscode-with-extensions.override {
                vscodeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
                  {
                    publisher = "vscodevim";
                    name = "vim";
                    version = "1.32.4";
                    sha256 = "sha256-+hyJZinWsa6U+s0fdrx2wUi6tOV3FNKf8O1qMMZEdkQ=";
                  }
                  {
                    publisher = "jnoortheen";
                    name = "nix-ide";
                    version = "0.5.7";
                    sha256 = "sha256-6wIjuvMlA+mwg5gzctkfOAdaQLBy2K6YcV3kJxK3VOo=";
                  }
                  {
                    publisher = "timonwong";
                    name = "shellcheck";
                    version = "0.39.5";
                    sha256 = "sha256-8f9LGmNE8ilPYZmbJpmmAx9DkKJXbQzAia11rM3wTec=";
                  }
                  {
                    publisher = "mkhl";
                    name = "shfmt";
                    version = "1.5.2";
                    sha256 = "sha256-Mff3ZpxnLp/cEB17T0KGZ4GWG8jN4VxrfR/wIEi2ouM=";
                  }
                ];
              })
            ];
          };
        };
      }
    );
}
