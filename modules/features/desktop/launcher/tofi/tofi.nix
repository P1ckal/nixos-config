# modules/features/desktop/tofi/tofi.nix
#
# Curated launcher: tofi in dmenu mode, fed from config.launcher.entries.
# Only what you list in launcher.entries shows up (no .desktop / $PATH scan).
{ self, ... }: {
  flake.wrappers.tofi =
    {
      config,
      wlib,
      ...
    }:
    let
      c = config.theme.colors;
    in
    {
      imports = [
        wlib.wrapperModules.tofi
        self.modules.generic.theme
      ];

      settings = {
        # --- behaviour ---
        fuzzy-match = true;
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
        font = "monospace";
        font-size = 16;

        # --- colors ---
        background-color = "${c.mSurface}cc";
        text-color = "${c.mOnSurface}ff";
        prompt-color = "${c.mSecondary}ff";
        input-color = "${c.mPrimary}ff";
        selection-color = "${c.mPrimary}80";
        selection-background = "#00000000";

        # --- other ---
      };
    };

  flake.modules.homeManager.tofi =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      tofi = self.wrappers.tofi.wrap {
        inherit pkgs;
        theme = { inherit (config.theme) name mode; };
      };

      entries = config.launcher.entries;
      names = lib.attrNames entries;

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
          | ${lib.getExe tofi} --history-file "$hist/history") || exit 0

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
      home.packages = [
        tofi
        launcher
      ];
    };

  flake.nixosModules.tofi = { ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.tofi ];
  };
}
