{
  description = "Nix develop flake competitive programming practice";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

	rustToolchainStable = pkgs.rust-bin.stable.latest.default;
      in
      {
        devShells.default = pkgs.mkShell rec {
          buildInputs = [
	    #rust
	    rustToolchainStable
	    #python
	    (pkgs.python3.withPackages (python-pkgs: [
	      python-pkgs.numpy
	    ]))
	    pkgs.basedpyright
	    # c++
	    pkgs.gcc
	    # misc
            pkgs.pkg-config
          ];

          LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath buildInputs}";

          shellHook = ''
          '';
        };
      }
    );
}
