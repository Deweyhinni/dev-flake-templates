{
  description = "java dev flake with maven";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem(system:
      let
	overlays = [];
	pkgs = import nixpkgs {
	  inherit system overlays;
	};
	javaVersion = pkgs.jdk24;
      in
      {
	devShells.default = pkgs.mkShell rec {
	  buildInputs = with pkgs; [
	    javaVersion
	    gradle
	    jdt-language-server
	    google-java-format
	  ];

	  shellHook = ''
	    export JAVA_HOME="${javaVersion}"
            export GRADLE_OPTS="-Xmx3g -Xms1g -Dorg.gradle.daemon=true -Dorg.gradle.parallel=true"
            export GRADLE_USER_HOME="$PWD/.gradle"
            export _JAVA_OPTIONS="-Xmx4g -Xms1g"
	  '';
	};
      }
    );
}
