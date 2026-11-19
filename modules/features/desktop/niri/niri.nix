{ self, ... }:
{
  flake.wrappers.niri =
    {
      config,
      wlib,
      lib,
      ...
    }:
    let
      c = config.theme.colors;
    in
    {
      imports = [
        wlib.wrapperModules.niri
        self.modules.generic.theme
      ];

      settings = lib.mapAttrsRecursive (_: lib.mkDefault) {
        input = {
          keyboard = {
            xkb.layout = "us";
            numlock = _: { };
          };

          touchpad = {
            tap = _: { };
            natural-scroll = _: { };
          };

          warp-mouse-to-focus = _: { };
          focus-follows-mouse = _: {
            props.max-scroll-amount = "0%";
          };
        };

        cursor = {
          xcursor-theme = "default";
          xcursor-size = 48;
        };

        layout = {
          gaps = 4;
          center-focused-column = "never";

          preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];

          preset-window-heights = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
            { proportion = 1.0; }
          ];

          default-column-width = {
            proportion = 0.5;
          };

          focus-ring = {
            width = 2;
            urgent-color = "${c.mError}";
            inactive-color = "${c.mSurface}";
            active-gradient = _: {
              props = {
                from = "${c.mSurface}";
                to = "${c.mPrimary}";
                angle = 135;
              };
            };
          };

          border = {
            off = _: { };
            width = 2;
            active-color = "${c.mPrimary}";
            inactive-color = "${c.mSurface}";
            urgent-color = "${c.mError}";
          };

          tab-indicator = {
            gap = 0;
            active-color = "${c.mPrimary}";
            inactive-color = "${c.mOutline}";
            urgent-color = "${c.mError}";
          };

          shadow = {
            on = _: { };
            softness = 30;
            spread = 5;
            offset = _: {
              props = {
                x = 0;
                y = 5;
              };
            };
            color = "${c.mShadow}70";
          };

          insert-hint = {
            color = "${c.mPrimary}80";
          };

        };

        hotkey-overlay.skip-at-startup = _: { };
        prefer-no-csd = _: { };
        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

        binds = {

          "Mod+Shift+Slash".show-hotkey-overlay = _: { };

          "Mod+Return" = _: {
            hotkey-overlay-title = "Open a Terminal";
            content.spawn = [ "kitty" ];
          };

          "Mod+grave" = _: {
            repeat = false;
            hotkey-overlay-title = "Run an Application";
            content.spawn = [ "launcher" ];
          };

          "Mod+Delete" = _: {
            content.spawn = [
              "noctalia"
              "msg"
              "session"
              "lock"
            ];
          };

          "XF86AudioRaiseVolume" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%+"
            ];
          };
          "XF86AudioLowerVolume" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "5%-"
            ];
          };
          "XF86AudioMute" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
          };
          "XF86AudioMicMute" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
          };

          "XF86AudioPlay" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "noctalia"
              "msg"
              "media"
              "toggle"
            ];
          };
          "XF86AudioPrev" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "noctalia"
              "msg"
              "media"
              "previous"
            ];
          };
          "XF86AudioNext" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "noctalia"
              "msg"
              "media"
              "next"
            ];
          };

          "XF86MonBrightnessUp" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "noctalia"
              "msg"
              "brightness-up"
            ];
          };
          "XF86MonBrightnessDown" = _: {
            props.allow-when-locked = true;
            content.spawn = [
              "noctalia"
              "msg"
              "brightness-down"
            ];
          };

          "Mod+Escape" = _: {
            props.repeat = false;
            content.toggle-overview = _: { };
          };

          "Mod+Q".close-window = _: { };

          # Move around
          "Mod+Up".focus-window-or-workspace-up = _: { };
          "Mod+K".focus-window-or-workspace-up = _: { };
          "Mod+Down".focus-window-or-workspace-down = _: { };
          "Mod+J".focus-window-or-workspace-down = _: { };
          "Mod+Left".focus-column-left = _: { };
          "Mod+H".focus-column-left = _: { };
          "Mod+Right".focus-column-right = _: { };
          "Mod+L".focus-column-right = _: { };

          # Move stuff around
          "Mod+Shift+Up".move-window-up-or-to-workspace-up = _: { };
          "Mod+Shift+K".move-window-up-or-to-workspace-up = _: { };
          "Mod+Shift+Down".move-window-down-or-to-workspace-down = _: { };
          "Mod+Shift+J".move-window-down-or-to-workspace-down = _: { };
          "Mod+Shift+Left".move-column-left = _: { };
          "Mod+Shift+H".move-column-left = _: { };
          "Mod+Shift+Right".move-column-right = _: { };
          "Mod+Shift+L".move-column-right = _: { };

          "Mod+Shift+Alt+Up".move-column-to-workspace-up = _: { };
          "Mod+Shift+Alt+Down".move-column-to-workspace-down = _: { };

          "Mod+Alt+Up".focus-workspace-up = _: { };
          "Mod+Alt+Down".focus-workspace-down = _: { };
          "Mod+Alt+Left".focus-column-left = _: { };
          "Mod+Alt+Right".focus-column-right = _: { };

          "Mod+Ctrl+Left".focus-monitor-left = _: { };
          "Mod+Ctrl+Down".focus-monitor-down = _: { };
          "Mod+Ctrl+Up".focus-monitor-up = _: { };
          "Mod+Ctrl+Right".focus-monitor-right = _: { };

          "Mod+Shift+Ctrl+Left".move-column-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+Down".move-column-to-monitor-down = _: { };
          "Mod+Shift+Ctrl+Up".move-column-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+Right".move-column-to-monitor-right = _: { };

          # Move every workspace to another monitor.
          "Mod+Shift+Ctrl+Home".move-workspace-to-monitor-left = _: { };
          "Mod+Shift+Ctrl+End".move-workspace-to-monitor-right = _: { };
          "Mod+Shift+Ctrl+Page_Up".move-workspace-to-monitor-up = _: { };
          "Mod+Shift+Ctrl+Page_Down".move-workspace-to-monitor-down = _: { };

          # Mouse-related movements
          "Mod+WheelScrollDown".focus-column-right = _: { };
          "Mod+WheelScrollUp".focus-column-left = _: { };
          "Mod+Shift+WheelScrollDown".move-column-right = _: { };
          "Mod+Shift+WheelScrollUp".move-column-left = _: { };

          "Mod+Alt+WheelScrollUp".focus-window-or-workspace-up = _: { };
          "Mod+Alt+WheelScrollDown".focus-window-or-workspace-down = _: { };
          "Mod+Alt+Shift+WheelScrollUp".move-window-up-or-to-workspace-up = _: { };
          "Mod+Alt+Shift+WheelScrollDown".move-window-down-or-to-workspace-down = _: { };

          "Mod+Comma".consume-or-expel-window-left = _: { };
          "Mod+Period".consume-or-expel-window-right = _: { };

          "Mod+F".fullscreen-window = _: { };
          "Mod+Shift+F".maximize-window-to-edges = _: { };

          "Mod+Minus" = _: {
            content.set-column-width = "-15%";
          };
          "Mod+Equal" = _: {
            content.set-column-width = "+15%";
          };
          "Mod+0" = _: {
            content.set-column-width = "50%";
          };

          "Mod+Shift+Minus" = _: {
            content.set-window-height = "-10%";
          };
          "Mod+Shift+Equal" = _: {
            content.set-window-height = "+10%";
          };

          "Mod+Shift+Space".toggle-window-floating = _: { };
          "Mod+Space".switch-focus-between-floating-and-tiling = _: { };
          "Mod+Tab".toggle-column-tabbed-display = _: { };

          "Print".screenshot = _: { };
          "Ctrl+Print".screenshot-screen = _: { };
          "Alt+Print".screenshot-window = _: { };
          "Mod+Print" = _: {
            content.spawn = [
              "noctalia"
              "msg"
              "plugin"
              "noctalia/screen_recorder:service"
              "all"
              "toggle"
            ];
          };

          "Mod+Shift+E".quit = _: { };
          "Ctrl+Alt+Delete".quit = _: { };
          "Mod+Shift+Delete".power-off-monitors = _: { };
        };

        window-rules = [
          {
            matches = [
              {
                app-id = "zen$";
                title = "^Picture-in-Picture$";
              }
            ];
            open-floating = true;
            open-focused = false;
            default-floating-position = _: {
              props = {
                x = 0;
                y = 0;
                relative-to = "bottom-right";
              };
            };
            default-column-width = {
              fixed = 640;
            };
            default-window-height = {
              fixed = 360;
            };
          }

          {
            geometry-corner-radius = 8;
            clip-to-geometry = true;
            open-focused = true;
          }
        ];
      };
    };
  flake.nixosModules.niri =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      base = self.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      niri = base.wrap ([ { theme.name = config.theme.name; } ] ++ config.my.niri.modules);
    in
    {
      options.my.niri.modules = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [ ];
      };
      config = {
        programs.niri = {
          enable = true;
          package = niri;
        };
        environment.systemPackages = with pkgs; [ xwayland-satellite ];
      };
    };
}
