{ ... }: {
  flake.modules.homeManager.starship = { pkgs, ...}: {
    programs.starship = {
      enable = true;
      presets = ["bracketed-segments"];
      settings = {
        
      };
      enableFishIntegration = true;
    };
  };
}
