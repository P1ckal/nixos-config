# modules/shell/devenv/devenv.nix
{ ... }: {
  flake.modules.homeManager.devenv = { pkgs, ...}: {
    home.packages = [ pkgs.devenv ];
  };
}
