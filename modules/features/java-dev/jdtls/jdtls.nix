{ ... }: {
  flake.modules.homeManager.jdtls = { pkgs, ...}: {
    home.packages = [ pkgs.jdt-language-server ];
    # xdg.configFile."kickoff" = {
    #   source = ./config;
    #   recursive = true;
    # };
  };
}
