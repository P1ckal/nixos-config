# modules/desktop/kickoff/kickoff.nix
{ ... }: {
  flake.modules.homeManager.kickoff = { pkgs, ...}: {
    home.packages = [ pkgs.kickoff ];
    xdg.configFile."kickoff" = {
      source = ./config;
      recursive = true;
    };
  };
}
