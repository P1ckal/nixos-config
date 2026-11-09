{ ... }: {
  flake.modules.homeManager.intellij =
    {
      lib,
      pkgs,
      ...
    }:
    {
      launcher.entries."IntelliJ Idea" = lib.getExe pkgs.jetbrains.idea;

      home.packages = [ pkgs.jetbrains.idea ];
      # xdg.configFile."kickoff" = {
      #   source = ./config;
      #   recursive = true;
      # };
    };
}
