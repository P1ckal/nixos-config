{ self, ... }: {
  # Home side
  flake.modules.homeManager.shell = {
    imports = with self.modules.homeManager; [
      fish
      helix
      starship
      zoxide
      direnv
      devenv
      hyfetch
      ripgrep
      yazi
      git
    ];
  };

  # System side
  flake.nixosModules.shell = {
    imports = with self.nixosModules; [
      fish
      lazygit
      git
    ];
    home-manager.sharedModules = [ self.modules.homeManager.shell ];
  };
}
