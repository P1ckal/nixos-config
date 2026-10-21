# modules/shell/fish/helix/helix.nix
{ ... }: {
  flake.modules.homeManager.helix = { pkgs, ...}: {
    home.packages = [ pkgs.helix ];
    xdg.configFile."helix" = {
      source = ./config;
      recursive = true;
    };
  };
}
