{ inputs, ... }: {
  flake.modules.homeManager.noctalia = { ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      settings = {
        hooks.started = "kitty --start-as=hidden --listen-on=unix:@kitty";

        bar = {
          default = {
            auto_hide = true;
            reserve_space = false;
          };
        };

        theme = {
          builtIn = "Noctalia";
          mode = "dark";
          source = "wallpaper";
          community-palette = "Oxocarbon";
          wallpaper_scheme = "soft";

          templates = {
            builtin_ids = [
              "btop"
              "cava"
              "gtk3"
              "gtk4"
              "kitty"
              "niri"
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
          transition = [ "honeycomb" "melt" "pixel" "stripes" "vortex" ];
          transition_duration = 1000;
        };

        notification = {
          history_retention_hours = "3";
        };

        plugins = {
          enabled = [ "noctalia/screen_recorder" ];
        };
      };
    };
  };
}
