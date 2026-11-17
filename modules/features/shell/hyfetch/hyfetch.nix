{ self, ... }: {
  flake.wrappers.hyfetch =
    {
      lib,
      wlib,
      pkgs,
      ...
    }:
    {
      imports = [ wlib.wrapperModules.hyfetch ];

      runtimePkgs = [ pkgs.fastfetch ];

      settings = lib.mapAttrs (_: lib.mkDefault) {
        preset = "demigirl";
        mode = "rgb";
        auto_detect_light_dark = false;
        light_dark = "dark";
        lightness = 0.56;
        color_align.mode = "horizontal";
        backend = "fastfetch";
        distro = "nixos";
        pride_month_disable = false;
      };
    };

  flake.modules.homeManager.hyfetch = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.hyfetch ];
  };
}
