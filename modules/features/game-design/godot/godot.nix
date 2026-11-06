{ ... }: {
  flake.modules.homeManager.godot = { pkgs, ...}: {
    home.packages = [ pkgs.godot_4_7 ];
    # xdg.configFile."godot" = {
    #   source = ./config;
    #   recursive = true;
    # };
  };
}
