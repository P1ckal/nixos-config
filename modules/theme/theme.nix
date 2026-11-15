# modules/theme/theme.nix
#
# Exposes the palettes in ./_palettes/ to every home-manager module.
#
# One file per palette: ./_palettes/<name>.nix is picked up automatically and
# becomes `theme.name = "<name>"`. No registration needed. (The underscore on
# the directory keeps import-tree from treating the files as flake-parts
# modules.)
#
#   config.theme.name     which palette is active
#   config.theme.mode     "dark" or "light"
#   config.theme.colors   the active palette for that mode (read-only)
#   config.theme.palettes every palette, both modes (read-only)
#
# Usage in any home-manager module:
#   { config, ... }: let c = config.theme.colors; in {
#     programs.foo.settings.background = c.mSurface;
#   }
#
# It is added to home-manager.sharedModules in modules/home/home-manager.nix,
# so it is available everywhere. To use another palette, set `theme.name`
# (e.g. from a host module via
# `home-manager.sharedModules = [ { theme.name = "catppuccin"; } ];`).
{ ... }: {
  flake.modules.homeManager.theme = { config, lib, ... }:
    let
      # Every <name>.nix in ./_palettes becomes a palette called <name>.
      palettes = lib.mapAttrs' (file: _: lib.nameValuePair (lib.removeSuffix ".nix" file) (import (./_palettes + "/${file}")))
        (lib.filterAttrs (file: type: type == "regular" && lib.hasSuffix ".nix" file) (builtins.readDir ./_palettes));
    in
    {
      options.theme = {
        name = lib.mkOption {
          type = lib.types.enum (builtins.attrNames palettes);
          default = "pixel-purple";
          description = "Which palette from modules/theme/_palettes/ to use (file name without .nix).";
        };

        mode = lib.mkOption {
          type = lib.types.enum [ "dark" "light" ];
          default = "dark";
          description = "Which variant of the palette to use.";
        };

        palettes = lib.mkOption {
          type = lib.types.attrsOf lib.types.attrs;
          default = palettes;
          readOnly = true;
          description = "All available palettes (both modes), one per file in _palettes/.";
        };

        colors = lib.mkOption {
          type = lib.types.attrs;
          readOnly = true;
          description = "The active palette for the active mode.";
        };
      };

      config.theme.colors = palettes.${config.theme.name}.${config.theme.mode};
    };
}
