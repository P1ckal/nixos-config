{ self, ... }: {
  flake.wrappers.helix =
    {
      wlib,
      ...
    }:
    let
      darker = "#292929";
      selection = "#37232D";
      selectionFG = "#F2AAC7";
    in
    {
      imports = [ wlib.wrapperModules.helix ];
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

        "palette" = {
          darker = darker;
        };
      };
    };

  flake.modules.fish.helix = { lib, ... }: {
    configFile.content = lib.mkAfter ''
      set -gx EDITOR hx
    '';
  };

  flake.modules.homeManager.helix = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helix ];
    home.sessionVariables.EDITOR = "hx";
  };
}
