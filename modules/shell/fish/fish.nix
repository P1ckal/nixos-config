# modules/shell/fish/fish.nix
{ ... }: {
  flake.nixosModules.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.user01.shell = pkgs.fish;
  };

  flake.modules.homeManager.fish = {
    programs.fish.enable = true;
    programs.fish.interactiveShellInit = builtins.readFile ./config.fish;
  };
}
