{ config, ... }: {
  flake.wrappers.ruff =
    {
      config,
      lib,
      wlib,
      pkgs,
      ...
    }:
    let
      toml = pkgs.formats.toml { };
    in
    {
      imports = [ wlib.modules.default ];

      options.settings = lib.mkOption {
        type = toml.type;
        default = { };
        description = "Ruff configuration";
      };

      config = {
        package = pkgs.ruff;

        settings = lib.mapAttrs (_: lib.mkDefault) {

        };

        flags."--config" = toml.generate "ruff-config.yml" config.settings;
      };

    };

  flake.nixosModules.ruff = { lib, ... }: {
    imports = [
      config.flake.wrappers.ruff.install
    ];
    wrappers.ruff.enable = lib.mkDefault true;
  };
}
