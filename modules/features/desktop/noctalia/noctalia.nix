{ self, inputs, ... }: {
  flake.wrappers.noctalia =
    {
      config,
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [
        wlib.wrapperModules.noctalia
        self.modules.generic.theme
      ];
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # colors = palette;
      colors = config.theme.palettes.${config.theme.name};

      settings = {
        hooks.started = "kitty --start-as=hidden --listen-on=unix:@kitty";

        bar = {
          default = {
            auto_hide = true;
            reserve_space = false;
          };
        };

        theme = {
          source = "custom";
          # required naming convention for the wrapper
          custom_palette = "custom";
          mode = config.theme.mode;

          templates = {
            builtin_ids = [
              "gtk3"
              "gtk4"
              "qt"
            ];
            community_ids = [
              "zen-browser"
              "yazi"
            ];

          };
        };

        wallpaper = {
          enabled = true;
          default.path = ./pixel_purple_wallpaper.png;
        };

        widget.clock.format = "%I:%M %p";

        calendar = {
          event_time_format = "%I:%M %p";
          event_date_format = "%A %e %b";
          enabled = true;
          account.personal_google.type = "google";
          account.personal_google.color = "primary";
        };

        lockscreen = {
          fingerprint = true;
          transition = [
            "honeycomb"
            "melt"
            "pixel"
            "stripes"
            "vortex"
          ];
          transition_duration = 1000;
        };

        notification = {
          history_retention_hours = "3";
        };

        plugins = {
          enabled = [ "noctalia/screen_recorder" ];
        };

        brightness.minimum_brightness = 0.01;
      };
    };

  flake.modules.homeManager.noctalia = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia ];
  };
}
