{ self, ... }: {
  flake.wrappers.kitty =
    {
      config,
      wlib,
      lib,
      ...
    }:
    let
      c = config.theme.colors;
      t = c.terminal;

      # color0..7 are the normal ANSI colors, color8..15 the bright ones.
      ansiNames = [
        "black"
        "red"
        "green"
        "yellow"
        "blue"
        "magenta"
        "cyan"
        "white"
      ];
      ansi = lib.listToAttrs (
        lib.imap0 (i: color: lib.nameValuePair "color${toString i}" color) (
          map (n: t.normal.${n}) ansiNames ++ map (n: t.bright.${n}) ansiNames
        )
      );
    in
    {
      imports = [
        wlib.wrapperModules.kitty
        self.modules.generic.theme
      ];

      env.KITTY_CONFIG_DIRECTORY = "/var/empty";

      settings = {
        cursor_shape = "beam";

        touch_scroll_multiplier = 5.0;

        confirm_os_window_close = 0;

        allow_remote_control = "socket";
        listen_on = "unix:@kitty";

        shell_integration = "enabled";
      }
      // ansi
      // {
        # --- colors (from config.theme.colors) ---
        cursor = t.cursor;
        cursor_text_color = t.cursorText;
        background = t.background;
        foreground = t.foreground;
        selection_foreground = t.selectionFg;
        selection_background = t.selectionBg;
        active_border_color = c.mPrimary;
        inactive_border_color = c.mSurfaceVariant;
        url_color = c.mPrimary;

        active_tab_foreground = c.mOnPrimary;
        active_tab_background = c.mPrimary;
        inactive_tab_foreground = c.mOnSurfaceVariant;
        inactive_tab_background = c.mSurfaceVariant;
        cursor_trail_color = c.mOnSurfaceVariant;
      };
    };
  flake.modules.homeManager.kitty =
    {
      lib,
      pkgs,
      ...
    }:
    {
      home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.kitty ];

      launcher.entries."Kitty" = lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.kitty;
    };
}
