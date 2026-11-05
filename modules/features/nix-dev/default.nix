{ self, ... }: {
  # Home side
  flake.modules.homeManager.nix-dev = {
    imports = with self.modules.homeManager; [
      nil
      nixd
    ];
  };

  # System side
  flake.nixosModules.nix-dev = {
    home-manager.sharedModules = [ self.modules.homeManager.nix-dev ];
  };
}
