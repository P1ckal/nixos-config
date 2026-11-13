{
  # Import self and universal inputs (different to inputs')
  self,
  inputs,
  ...
}:
{
  # Define nixosConfiguration with hostname "host"
  flake.nixosConfigurations.framework13pro = inputs.nixpkgs.lib.nixosSystem {
    # Define modules to import
    modules = with self.nixosModules; [
      hostConfiguration
      hostDisk
      system
      laptop
      home-manager
      shell
      desktop
      zen-browser
      discord
      minecraft
      steam
      java-dev
      nix-dev
      game-design
      python-dev
      tailscale
    ];
  };
}
