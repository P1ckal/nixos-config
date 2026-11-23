{ self, ... }: {
  flake.modules.homeManager.direnv = { pkgs, ... }: {
    home.packages = [ pkgs.direnv ];
  };

  flake.modules.fish.direnv = { pkgs, lib, ... }: {
    configFile.content = lib.mkAfter ''
      if status is-interactive
        ${lib.getExe pkgs.direnv} hook fish | source
      end
    '';
  };

  flake.nixosModules.direnv = { ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.direnv ];
    my.fish.modules = [
      self.modules.fish.direnv

    ];
  };
}
