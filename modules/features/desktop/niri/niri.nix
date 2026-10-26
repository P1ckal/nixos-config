{ ... }:
{
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [ xwayland-satellite ];
  };

  flake.modules.homeManager.niri = {
    xdg.configFile."niri" = {
      source = ./config;
      recursive = true;
    };
  };
}
