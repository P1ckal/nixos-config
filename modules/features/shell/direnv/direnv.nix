{ self, ... }: {
  flake.modules.homeManager.direnv = { pkgs, ... }: {
    home.packages = [ pkgs.direnv ];
  };
  flake.nixosModules.direnv = { pkgs, lib, ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.direnv ];
    my.fish.modules = [
      {
        configFile.content = lib.mkAfter ''
          if status is-interactive
            ${lib.getExe pkgs.direnv} hook fish | source
          end
        '';
      }
    ];
  };
}
