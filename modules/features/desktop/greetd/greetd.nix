{ ... }: {
  flake.nixosModules.greetd =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      c = config.theme.colors;
      t = c.terminal;
      toml = pkgs.formats.toml { };

      tuigreetConfig = toml.generate "tuigreet-config.toml" {
        background = {
          # kind = "matrix";
          matrix = {
            head_color = t.foreground;
            bright_color = c.mPrimary;
            dim_color = c.mSurfaceVariant;
          };
        };

        theme = {
          container = c.mSurface;
          border = c.mPrimary;
          title = c.mPrimary;
          text = c.mOnSurface;
          greet = c.mOnSurface;
          time = c.mOnSurfaceVariant;
          prompt = c.mSecondary;
          input = c.mPrimary;
          action = c.mOnSurfaceVariant;
          button = c.mPrimary;
        };
      };
    in
    {
      services.greetd = {
        enable = true;
        settings.default_session = {
          command = lib.escapeShellArgs [
            (lib.getExe pkgs.tuigreet)
            "--config"
            "${tuigreetConfig}"
            "--time"
            "--remember"
            "--cmd"
            "niri-session"
          ];
          user = "greeter";
        };
      };
    };
}
