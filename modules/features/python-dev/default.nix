{ self, ... }: {
  # Home side: everything the user gets for the python-dev
  flake.modules.homeManager.python-dev = {
    imports = with self.modules.homeManager; [
      uv
      ty
    ];
    
  };

  # System side: only niri has a NixOS half
  flake.nixosModules.python-dev = {
    imports = with self.nixosModules; [
      uv
      ruff
    ];
    home-manager.sharedModules = [ self.modules.homeManager.python-dev ];
  };
}
