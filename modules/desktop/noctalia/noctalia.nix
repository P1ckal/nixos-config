# modules/desktop/noctalia/noctalia.nix
{ inputs, ... }: {
  flake.modules.homeManager.noctalia = { pkgs, ... }: {
    home.packages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    xdg.configFile."noctalia" = {
      source = ./config;
      recursive = true;
    };
  };
}
