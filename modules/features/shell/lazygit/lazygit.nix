{ self, config, ... }:
{
  flake.wrappers.lazygit =
    {
      config,
      lib,
      wlib,
      pkgs,
      ...
    }:
    let
      yaml = pkgs.formats.yaml { };
    in
    {
      imports = [ wlib.modules.default ];

      options.settings = lib.mkOption {
        type = yaml.type;
        default = { };
        description = "Lazygit configuration";
      };

      config = {
        package = pkgs.lazygit;

        settings = lib.mapAttrs (_: lib.mkDefault) {

        };

        flags."--use-config-file" = yaml.generate "lazygit-config.yml" config.settings;
        flags."--use-config-dir" = {
          data = "$HOME/.local/state/lazygit";
          esc-fn = v: v;
        };
      };

    };

  flake.modules.fish.lazygit = { ... }: {
    shellAliases.lg = "lazygit $argv";
  };

  flake.nixosModules.lazygit = { lib, ... }: {
    imports = [
      config.flake.wrappers.lazygit.install
    ];
    wrappers.lazygit.enable = lib.mkDefault true;

    my.fish.modules = [ self.modules.fish.lazygit ];
  };
}
