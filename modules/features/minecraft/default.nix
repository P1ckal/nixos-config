{ self, ... }: {
  # Home side
  flake.modules.homeManager.minecraft = {
    imports = with self.modules.homeManager; [
      prismlauncher
      waywall
    ];
  };

  # System side
  flake.nixosModules.minecraft = {
    home-manager.sharedModules = [ self.modules.homeManager.minecraft ];
  };
}
