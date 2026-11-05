{ ... }: {
  flake.modules.homeManager.nil = { pkgs, ...}: {
    home.packages = [ pkgs.nil ];
  };
}
