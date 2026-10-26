{ ... }:
{
  flake.nixosModules.lazygit = { pkgs, ... }: {
    programs.lazygit.enable = true;
    programs.lazygit.settings = {
      # idk settings
    };
  };
}
