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
          community-palette = "Rosey AMOLED";
          wallpaper_scheme = "m3-tonal-spot";

          templates = {
            builtin_ids = [ "btop" "cava" "gtk3" "gtk4" "kitty" "niri" "qt" ];
            community_ids = [ "zen-browser" "yazi" ];
            
          };
        };

          wallpaper = {
            enabled = true;
            default.path = ./pixel_purple_wallpaper.png;
          };

          widget.clock.format = "{:%I:%M %p}";

          calendar = {
            enabled = true;
            account.personal_google.type = "google";
          };

          lockscreen.fingerprint = true;

          notification = {
            history_retention_hours = "3";
          };

          plugins = {
            enabled = [ "noctalia/screen_recorder" ];
          };

          
      };
      
      
    };
    
    # xdg.configFile."noctalia" = {
    #   source = ./config;
    #   recursive = true;
    # };
  };
}
