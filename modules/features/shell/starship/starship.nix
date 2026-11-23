{ self, ... }: {
  flake.wrappers.starship = { wlib, ... }: {
    imports = [ wlib.wrapperModules.starship ];

    preset = [ "bracketed-segments" ];
    settings = { };
  };

  flake.modules.fish.starship =
    { pkgs, lib, ... }:
    let
      starship = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
    in
    {
      configFile.content = lib.mkAfter ''
        if status is-interactive
          ${lib.getExe starship} init fish | source
        end
      '';
    };

  flake.modules.homeManager.starship =
    { pkgs, ... }:
    let
      starship = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
    in
    {
      programs.starship = {
        enable = true;
        package = starship;
        enableFishIntegration = true;
      };

    };
  flake.nixosModules.starship = { ... }: {
    my.fish.modules = [ self.modules.fish.starship ];
  };
}
