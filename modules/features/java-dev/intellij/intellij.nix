{ ... }: {
  flake.modules.homeManager.intellij = { pkgs, ...}: {
    home.packages = [ pkgs.jetbrains.idea ];
    # xdg.configFile."kickoff" = {
    #   source = ./config;
    #   recursive = true;
    # };
  };
}
