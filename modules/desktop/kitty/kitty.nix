# modules/dektop/kitty/kitty.nix
{...}: {
  flake.modules.homeManager.kitty = {
    programs.kitty.enable = true;
    xdg.configFile."kitty" = {
      source = ./config;
      recursive = true;
    };
  };
}
