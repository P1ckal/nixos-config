{ ... }: {
  flake.modules.homeManager.hyfetch = { pkgs, ...}: {
    home.packages = [ pkgs.hyfetch pkgs.fastfetch ];
    xdg.configFile."hyfetch.json".source = ./config/hyfetch.json;

  };
}
