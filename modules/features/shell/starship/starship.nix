{ self, ... }: {
  flake.wrappers.starship = { wlib, ... }: {
    imports = [ wlib.wrapperModules.starship ];

    preset = [ "bracketed-segments" ];
    settings = { };
  };

  flake.modules.homeManager.starship = { pkgs, ... }: {
    programs.starship = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
      enableFishIntegration = true;
    };
  };
}
