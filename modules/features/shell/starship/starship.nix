{ self, ... }: {
  flake.wrappers.starship = { wlib, ... }: {
    imports = [ wlib.wrapperModules.starship ];

    preset = [ "bracketed-segments" ];
    settings = { };
  };

  flake.modules.homeManager.starship =
    { pkgs, lib, ... }:
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
  flake.nixosModules.starship =
    { pkgs, lib, ... }:
    let
      starship = self.packages.${pkgs.stdenv.hostPlatform.system}.starship;
    in
    {
      my.fish.modules = [
        {
          configFile.content = lib.mkAfter ''
            if status is-interactive
              ${lib.getExe starship} init fish | source
            end
          '';
        }
      ];
    };
}
