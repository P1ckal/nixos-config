# modules/shell/fish/fish.nix
{ ... }: {
  flake.nixosModules.fish = { pkgs, ... }: {
    programs.fish.enable = true;
    users.users.user01.shell = pkgs.fish;
  };

  flake.modules.homeManager.fish = { lib, ...}: {
    programs.fish.enable = true;
    
    programs.fish.interactiveShellInit = builtins.readFile ./config/config.fish;

    xdg.configFile."fish" = {
      source = lib.cleanSourceWith {
        src = ./config;
        filter = path: type: baseNameOf path != "config.fish";
      };
      recursive = true;
    };
  };
}
