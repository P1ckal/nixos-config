{ inputs, ... }: {
  flake.modules.homeManager.noctalia = { config, ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      # Written to ~/.config/noctalia/palettes/<name>.json
      customPalettes = config.theme.palettes;

      settings = {
        hooks.started = "kitty --start-as=hidden --listen-on=unix:@kitty";

        bar = {
          default = {
            auto_hide = true;
            reserve_space = false;
          };
        };

        theme = {
          # The palette comes from modules/theme/_palettes/, registered
          # above via `customPalettes`. noctalia themes the apps in
          # builtin_ids/community_ids from it. kitty and niri are deliberately
          # NOT in the list: their colors are generated straight from the
          # palette in kitty.nix / niri.nix (noctalia can't write over
          # home-manager's read-only files anyway).
          source = "custom";
          custom_palette = config.theme.name;
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
          transition = [ "honeycomb" "melt" "pixel" "stripes" "vortex" ];
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
  };
}
