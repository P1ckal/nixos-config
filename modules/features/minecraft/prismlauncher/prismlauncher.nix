# we'd want to use unwrapped so we can do glfw overrides
{ ... }: {
  flake.modules.homeManager.prismlauncher = { pkgs, ...}: {
    home.packages = [ pkgs.prismlauncher-unwrapped ];
    # xdg.configFile."init.lua".source = ./config/init.lua;
  };
}
