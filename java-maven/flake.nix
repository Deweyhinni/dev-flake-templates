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
	javaVersion = pkgs.jdk25;
      in
      {
	devShells.default = pkgs.mkShell rec {
	  buildInputs = with pkgs; [
	    javaVersion
	    maven
	    jdt-language-server
	    google-java-format
	  ];

	  shellHook = ''
	    export JAVA_HOME="${javaVersion}"
	    export MAVEN_OPTS="-Xmx2g -Xms512m"
            export _JAVA_OPTIONS="-Xmx4g -Xms1g"

	    if [ ! -f pom.xml ]; then
              echo "no pom.xml found. you probably want to run:"
              echo "mvn archetype:generate -DgroupId=com.example -DartifactId=my-app -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false"
            fi
	  '';
	};
      }
    );
}
