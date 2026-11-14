# modules/features/desktop/anyrun/anyrun.nix
#
# Curated launcher: anyrun with the "stdin" plugin only, fed from
# config.launcher.entries. Only what you list in launcher.entries shows up.
#
# Notes:
# - Written against anyrun 25.12.0 (what nixos-26.05 ships). The newer
#   "actions" plugin (custom commands in a RON file) is NOT in that version,
#   which is why this goes through stdin instead.
# - The stdin plugin reads stdin when it loads, so this doesn't work with
#   `anyrun daemon`. Each launch starts a fresh anyrun process.
{ self, ... }: {
  flake.modules.homeManager.anyrun =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      entries = config.launcher.entries;
      names = lib.attrNames entries;

      cases = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          name: cmd: "  ${lib.escapeShellArg name}) cmd=${lib.escapeShellArg cmd} ;;"
        ) entries
      );

      launcher = pkgs.writeShellScriptBin "launcher" ''
        # Toggle: if our anyrun is already open, close it and stop.
        # -f because the nixpkgs wrapper renames the process (.anyrun-wrapped),
        # so an exact-name match on "anyrun" would miss it.
        ${pkgs.procps}/bin/pkill -f 'anyrun.*libstdin' && exit 0

        # libstdin.so is resolved through ANYRUN_PLUGINS, which the nixpkgs
        # wrapper already sets.
        choice=$(printf '%s\n' ${lib.escapeShellArgs names} \
          | ${pkgs.anyrun}/bin/anyrun --plugins libstdin.so) || exit 0

        case "$choice" in
        ${cases}
          *) exit 0 ;;
        esac

        exec ${pkgs.util-linux}/bin/setsid -f ${pkgs.runtimeShell} -c "$cmd" >/dev/null 2>&1
      '';
    in
    {
      programs.anyrun = {
        enable = true;

        config = {
          # Plugins are chosen per launch via --plugins above; an empty list
          # silences home-manager's "no plugins" warning.
          plugins = [ ];

          x.fraction = 0.5;
          y.fraction = 0.3;
          width.absolute = 560;
          layer = "overlay";

          hideIcons = true;
          hidePluginInfo = true;
          closeOnClick = true;
          showResultsImmediately = true;
          maxEntries = 8;
        };

        extraConfigFiles."stdin.ron".text = ''
          Config(
            allow_invalid: false,
            max_entries: 8,
            // false = best fuzzy match first; true = keep your list order
            preserve_order: false,
          )
        '';

        # Same palette as your old kickoff setup.
        extraCss = ''
          @define-color accent #ff8cb3;
          @define-color bg-color #1a0f16;
          @define-color fg-color #7897b3;
          @define-color desc-color #ff8cb3;

          label.match {
            color: #ff8cb3;
          }
        '';
      };

      home.packages = [ launcher ];
    };

  flake.nixosModules.anyrun = { ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.anyrun ];
  };
}
