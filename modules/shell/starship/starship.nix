# modules/shell/starship/starship.nix
{ ... }: {
  flake.modules.homeManager.starship = { pkgs, ...}: {
    home.packages = [ pkgs.starship ];
    xdg.configFile."starship.toml".source = ./config/starship.toml;
  };
}
