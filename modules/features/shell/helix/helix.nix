{ self, ... }: {
  flake.wrappers.helix =
    {
      lib,
      wlib,
      pkgs,
      ...
    }:
    let
      toml = pkgs.formats.toml { };

      settings = {
        theme = "carbonfox-extra";
        editor = {
          soft-wrap = {
            enable = true;
            wrap-indicator = "";
          };

          auto-format = true;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          inline-diagnostics = {
            cursor-line = "hint";
            other-lines = "error";
          };
        };

        keys = {
          normal = {
            "X" = "extend_line_above";
            "A-x" = "extend_to_line_bounds";
          };
          select = {
            "X" = "extend_line_above";
            "A-x" = "extend_to_line_bounds";
          };
        };

      };

      darker = "#292929";
      selection = "#37232D";
      selectionFG = "#F2AAC7";
      themes.carbonfox-extra = {
        inherits = "carbonfox";

        "ui.virtual.jump-label" = {
          fg = selectionFG;
          modifiers = [
            "bold"
            "underlined"
          ];
        };

        "ui.selection" = {
          bg = selection;
        };
        "ui.selection.primary" = {
          bg = selection;
          fg = selectionFG;
          modifiers = [ "underlined" ];
        };
      };

      configFile = toml.generate "helix-config.toml" settings;

      themesDir = pkgs.runCommand "helix-themes" { } ''
        mkdir -p $out/themes
        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (name: theme: ''
            cp ${toml.generate "${name}.toml" theme} $out/themes/${name}.toml
          '') themes
        )}
      '';

      # helix's own runtime plus your themes; HELIX_RUNTIME replaces the default runtime
      runtime = pkgs.symlinkJoin {
        name = "helix-runtime";
        paths = [
          pkgs.helix.runtime
          themesDir
        ];
      };

    in
    {
      imports = [ wlib.modules.default ];
      config.package = pkgs.helix-unwrapped;
      config.flags."--config" = "${configFile}";
      config.env.HELIX_RUNTIME = "${runtime}";
    };

  flake.modules.homeManager.helix = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helix ];
    home.sessionVariables.EDITOR = "hx";
  };
}
