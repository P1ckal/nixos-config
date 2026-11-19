{ self, ... }: {
  # Home side
  flake.modules.homeManager.shell = {
    imports = with self.modules.homeManager; [
      helix
      starship
      devenv
      hyfetch
      ripgrep
      yazi
      git
      btop
    ];
  };

  # System side
  flake.nixosModules.shell = {
    imports = with self.nixosModules; [
      direnv
      fish
      starship
      lazygit
      git
      zip
      zoxide
    ];
    home-manager.sharedModules = [ self.modules.homeManager.shell ];
  };
}
