{ ... }: {
  flake.modules.homeManager.kitty = { lib, pkgs, ... }: {
    launcher.entries."Kitty" = lib.getExe pkgs.kitty;

    programs.kitty.enable = true;
    xdg.configFile."kitty" = {
      source = ./config;
      recursive = true;
    };
  };
}
