# modules/shell/zoxide/zoxide.nix
{ ... }: {
  flake.modules.homeManager.zoxide = { pkgs, ...}: {
    home.packages = [ pkgs.zoxide ];
  };
}
