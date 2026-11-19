{ self, ... }: {
  flake.modules.homeManager.zoxide = { pkgs, ... }: {
    home.packages = [ pkgs.zoxide ];
  };
  flake.nixosModules.zoxide = { pkgs, lib, ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.zoxide ];
    my.fish.modules = [
      {
        configFile.content = lib.mkAfter ''
          if status is-interactive
            ${lib.getExe pkgs.zoxide} init fish --cmd cd | source
          end
        '';
      }
    ];
  };
}
