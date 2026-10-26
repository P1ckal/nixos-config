{ ... }: {
  flake.modules.homeManager.zoxide = { pkgs, ...}: {
    home.packages = [ pkgs.zoxide ];
  };
}
