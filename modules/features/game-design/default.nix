{ self, ... }: {
  # Home side
  flake.modules.homeManager.game-design = {
    imports = with self.modules.homeManager; [
      godot
    ];
  };

  # System side
  flake.nixosModules.game-design = {
    imports = with self.nixosModules; [
      forgejo
    ];
    programs.git.lfs.enable = true;
    home-manager.sharedModules = [ self.modules.homeManager.game-design ];
  };
}
