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
                    version = "0.5.5";
                    sha256 = "sha256-epdEMPAkSo0IXsd+ozicI8bjPPquDKIzB3ONRUYWwn8=";
                  }
                  {
                    publisher = "timonwong";
                    name = "shellcheck";
                    version = "0.38.6";
                    sha256 = "sha256-0H/iPteisIru6bXizf4NtdpbrI2WSsWW/AvS1BtEicY=";
                  }
                  {
                    publisher = "mkhl";
                    name = "shfmt";
                    version = "1.5.1";
                    sha256 = "sha256-rk+ykkWHxgQyyOC8JyhyOinRPJHh9XxNRAVUzcF7TRI=";
                  }
                ];
              })
            ];
          };
        };
      }
    );
}
