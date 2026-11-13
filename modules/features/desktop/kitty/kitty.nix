{ ... }: {
  flake.modules.homeManager.kitty = { lib, pkgs, ... }: {
    launcher.entries."Kitty" = lib.getExe pkgs.kitty;

    programs.kitty = {
      enable = true;
      settings = {
        cursor_shape = "beam";

        touch_scroll_multiplier = 5.0;
        
        confirm_os_window_close = 0;
        
        allow_remote_control = "socket";
        listen_on = "unix:@kitty";
        
        shell_integration = "enabled";
        include = "${./noctalia.conf}";
      };
    };
  };
}
