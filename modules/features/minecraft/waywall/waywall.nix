{ ... }: {
  flake.modules.homeManager.waywall = { pkgs, ...}: {
    home.packages = [ pkgs.waywall ];
    xdg.configFile."init.lua".source = ./config/init.lua;
  };
}
