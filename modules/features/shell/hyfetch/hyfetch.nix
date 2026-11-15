{ ... }: {
  flake.modules.homeManager.hyfetch = { pkgs, ... }: {
    home.packages = [ pkgs.fastfetch ];
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "demigirl";
        mode = "rgb";
        auto_detect_light_dark = false;
        light_dark = "dark";
        lightness = 0.56;
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
        distro = "nixos";
        pride_month_disable = false;
      };
    };
  };
}
