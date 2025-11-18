{
  description = "Nix develop flake for this gleam project";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
	overlays = [];
	pkgs = import nixpkgs {
	  inherit system overlays;
	};
      in
      {
	devShells.default = pkgs.mkShell rec {
	  buildInputs = [
	    pkgs.gleam
	    pkgs.erlang
	    pkgs.rebar3
	  ];
	};
      } 
    );
}
