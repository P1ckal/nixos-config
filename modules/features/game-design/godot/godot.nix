{ ... }: {
  flake.modules.homeManager.godot =
    {
      lib,
      pkgs,
      ...
    }:
    {
      launcher.entries."Godot" = lib.getExe pkgs.godot_4_7;

      home.packages = [ pkgs.godot_4_7 ];
      # xdg.configFile."godot" = {
      #   source = ./config;
      #   recursive = true;
      # };
    };
}
