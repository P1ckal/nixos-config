{ ... }: {
  flake.modules.homeManager.discord = { config, lib, ... }: {
    launcher.entries."Discord" = lib.getExe config.programs.discord.package;

    programs.discord = {
      enable = true;

      settings = {

      };
    };
  };
}
