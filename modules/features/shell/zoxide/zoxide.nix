{ self, ... }: {
  flake.modules.fish.zoxide = { pkgs, lib, ... }: {
    configFile.content = lib.mkAfter ''
      if status is-interactive
        ${lib.getExe pkgs.zoxide} init fish --cmd cd | source
      end
    '';
  };

  flake.modules.homeManager.zoxide = { pkgs, ... }: {
    home.packages = [ pkgs.zoxide ];
  };

  flake.nixosModules.zoxide = { ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.zoxide ];
    my.fish.modules = [ self.modules.fish.zoxide ];
  };
}
