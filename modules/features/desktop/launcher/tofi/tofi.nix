# modules/features/desktop/tofi/tofi.nix
#
# Curated launcher: tofi in dmenu mode, fed from config.launcher.entries.
# Only what you list in launcher.entries shows up (no .desktop / $PATH scan).
{ self, ... }: {
  flake.modules.homeManager.tofi =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      entries = config.launcher.entries;
      c = config.theme.colors;

      # attrNames is alphabetical; tofi's history sorts by usage on top of this.
      names = lib.attrNames entries;

      # One case arm per entry: 'Name') cmd='command' ;;
      cases = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          name: cmd: "  ${lib.escapeShellArg name}) cmd=${lib.escapeShellArg cmd} ;;"
        ) entries
      );

      launcher = pkgs.writeShellScriptBin "launcher" ''
        # Toggle: if tofi is already open, close it and stop.
        ${pkgs.procps}/bin/pkill -x tofi && exit 0

        hist="''${XDG_CACHE_HOME:-$HOME/.cache}/tofi"
        mkdir -p "$hist"

        # dmenu mode: names in on stdin, selection out on stdout.
        # --history-file makes tofi sort frequently used entries first,
        # even in dmenu mode.
        choice=$(printf '%s\n' ${lib.escapeShellArgs names} \
          | ${pkgs.tofi}/bin/tofi --history-file "$hist/history") || exit 0

        case "$choice" in
        ${cases}
          *) exit 0 ;;
        esac

        # Run through sh so entries can use env vars, ~, flags, etc.
        # setsid -f detaches the app from the launcher.
        exec ${pkgs.util-linux}/bin/setsid -f ${pkgs.runtimeShell} -c "$cmd" >/dev/null 2>&1
      '';
    in
    {
      programs.tofi = {
        enable = true;

        settings = {
          # --- behaviour ---
          matching-algorithm = "fuzzy";
          require-match = true;
          history = true;
          # hint-font = false is faster at startup (slightly rougher glyph
          # positioning). Flip to true if text looks off.
          hint-font = false;
          ascii-input = true;

          # --- layout ---
          anchor = "center";
          width = "100%";
          height = "100%";
          num-results = 8;
          result-spacing = 25;
          padding-top = "35%";
          # padding-bottom = "35%";
          padding-left = "35%";
          # padding-right = 20;
          prompt-text = "run: ";
          corner-radius = 12;
          border-width = 0;
          outline-width = 0;

          # --- font ---
          # Set this explicitly instead of letting fontconfig pick.
          # Swap for any family `fc-list : family` shows you.
          font = "monospace";
          font-size = 16;

          # --- colors ---
          # From config.theme.colors; the trailing two hex digits are alpha.
          background-color = "${c.mSurface}cc";
          border-color = "${c.mPrimary}ff"; # unused while border-width = 0
          text-color = "${c.mOnSurface}ff";
          prompt-color = "${c.mSecondary}ff";
          input-color = "${c.mPrimary}ff";
          selection-color = "${c.mPrimary}80";
          selection-background = "#00000000"; # fully transparent

          # --- other ---
        };
      };

      home.packages = [ launcher ];
    };

  flake.nixosModules.tofi = { ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.tofi ];
  };
}
