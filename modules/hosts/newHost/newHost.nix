{
  # Import self and universal inputs (different to inputs')
  self,
  inputs,
  ...
}: {
  # Define nixosConfiguration with hostname "newHost"
  flake.nixosConfigurations.newHost = inputs.nixpkgs.lib.nixosSystem {
    # Define modules to import
    modules = with self.nixosModules; [
      newHostConfiguration
      system
    ];
  };
}
