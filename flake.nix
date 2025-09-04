{
  description = "ARM dev env: gcc-arm-embedded, make, cmake, stlink, VS Code + Cortex-Debug";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true; # VS Code is unfree
        };

 #       vscodeWithExtensions = pkgs.vscode-with-extensions.override {
#          vscode = pkgs.vscode;
#          vscodeExtensions = with pkgs.vscode-extensions; [
#           marus25.cortex-debug                                        ## Needs debug-tracker-vscode, MemoryView, Rtos Views, Peripheral Viewer Adding to nixpkgs 
#	    ms-vscode.cmake-tools
#	    ms-vscode.cpptools
#          ];
#        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            gcc-arm-embedded
            gnumake
            cmake
            stlink
 #          vscodeWithExtensions
            vscode-fhs
          ];

        };
      });
}

