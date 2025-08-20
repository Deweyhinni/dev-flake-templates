{
  description = "nix development flake templates";

  outputs = { self, nixpkgs }: {
    templates = {
      rust = {
	description = "basic rust dev environment";
	path = ./rust;
      };
      java-maven = {
	description = "java with maven dev environment";
	path = ./java-maven;
      };
      java-gradle = {
	description = "java with maven dev environment";
	path = ./java-gradle;
      };
    };
  };
}
