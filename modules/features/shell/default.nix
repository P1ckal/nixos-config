{ self, ... }: {
  # Home side
  flake.modules.homeManager.shell = {
    imports = with self.modules.homeManager; [
      helix
      starship
      zoxide
      direnv
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
      fish
      starship
      lazygit
      git
      zip
    ];
    home-manager.sharedModules = [ self.modules.homeManager.shell ];
  };
}
