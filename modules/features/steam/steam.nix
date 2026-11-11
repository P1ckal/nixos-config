{ self, ... }: {
  flake.modules.homeManager.steam = { pkgs, lib, ... }: {
    launcher.entries."Steam" = lib.getExe pkgs.steam;
  };

  flake.nixosModules.steam = {
    programs.steam.enable = true;
    home-manager.sharedModules = [ self.modules.homeManager.steam ];
  };
}
