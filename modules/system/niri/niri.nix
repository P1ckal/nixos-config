# modules/system/niri/niri.nix
{ ... }:
{
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [ kitty fuzzel ];
  };

  flake.modules.homeManager.niri = {
    xdg.configFile."niri" = {
      source = ./config;
      recursive = true;
    };
  };
}
