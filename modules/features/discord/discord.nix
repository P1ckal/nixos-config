{ self, ... }: {
  flake.modules.homeManager.discord = { config, lib, ... }: {
    launcher.entries."Discord" = lib.getExe config.programs.discord.package;

    programs.discord = {
      enable = true;

      settings = {

      };
    };
  };

  flake.nixosModules.discord = {
    home-manager.sharedModules = [ self.modules.homeManager.discord ];
  };
}
