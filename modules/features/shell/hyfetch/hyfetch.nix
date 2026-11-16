{ self, ... }: {
  flake.wrappers.hyfetch =
    {
      config,
      lib,
      wlib,
      pkgs,
      ...
    }:
    let
      json = pkgs.formats.json { };
    in
    {
      imports = [ wlib.modules.default ];

      options.settings = lib.mkOption {
        inherit (json) type;
        default = { };
        description = "Contents of hyfetch.json";
      };

      config = {
        package = pkgs.hyfetch;
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

        flags."--config-file" = json.generate "hyfetch.json" config.settings;
      };
    };
  flake.modules.homeManager.hyfetch = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.hyfetch ];
  };
}
