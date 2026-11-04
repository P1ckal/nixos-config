{ self, ... }: {
  # Home side
  flake.modules.homeManager.java-dev = {
    imports = with self.modules.homeManager; [
      intellij
      jdtls
    ];
  };

  # System side
  flake.nixosModules.java-dev = {
    home-manager.sharedModules = [ self.modules.homeManager.java-dev ];
  };
}
