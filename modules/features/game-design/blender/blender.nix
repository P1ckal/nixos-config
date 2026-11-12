{ ... }: {
  flake.modules.homeManager.blender =
    {
      lib,
      pkgs,
      ...
    }:
    {
      launcher.entries."Blender" = lib.getExe pkgs.blender;

      home.packages = [ pkgs.blender ];
      # xdg.configFile."blender" = {
      #   source = ./config;
      #   recursive = true;
      # };
    };
}
