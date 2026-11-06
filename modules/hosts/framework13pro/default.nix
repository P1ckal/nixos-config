{
	# Import self and universal inputs (different to inputs')
  self,
  inputs,
  ...
}: {
	# Define nixosConfiguration with hostname "host"
  flake.nixosConfigurations.framework13pro = inputs.nixpkgs.lib.nixosSystem {
		# Define modules to import
    modules = with self.nixosModules; [
      hostConfiguration
      hostDisk
      system
      home-manager
      shell
      desktop
      minecraft
      java-dev
      nix-dev
      game-design
    ];
  };
}
