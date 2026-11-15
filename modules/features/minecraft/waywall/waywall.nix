{ ... }: {
  flake.modules.homeManager.waywall = { pkgs, ...}: {
    home.packages = [ pkgs.waywall ];
    xdg.configFile."waywall/init.lua".source = ./config/init.lua;
  };
}
