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
      python = {
	description = "basic python dev environment with basedpyright";
	path = ./python;
      };
      gleam = {
	description = "basic gleam dev environment";
	path = ./gleam;
      };
    };
  };
}
