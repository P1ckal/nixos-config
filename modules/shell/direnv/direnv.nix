# modules/shell/direnv/direnv.nix
{ ... }: {
  flake.modules.homeManager.direnv = { pkgs, ...}: {
    home.packages = [ pkgs.direnv ];
  };
}
