# modules/desktop/launcher/launcher.nix
{ ... }: {
  flake.modules.homeManager.launcher-options = { lib, ... }: {
    options.launcher.entries = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = { };
      example = { "Kitty" = "kitty"; };
      description = "Display name to command, shown in the launcher.";
    };
  };
}
