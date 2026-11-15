{ self, ... }: {
  flake.modules.homeManager.kickoff =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      c = config.theme.colors;

      entriesFile = pkgs.writeText "kickoff-entries" (
        lib.concatStringsSep "\n" (
          lib.mapAttrsToList (name: cmd: "${name} = ${cmd}") config.launcher.entries
        )
        + "\n"
      );

      launcher = pkgs.writeShellScriptBin "launcher" ''
        ${pkgs.procps}/bin/pkill 'kickoff' && exit 0
        hist="''${XDG_CACHE_HOME:-$HOME/.cache}/kickoff"
        mkdir -p "$hist"
        exec ${lib.getExe pkgs.kickoff} --from-file ${entriesFile} \
          --history "$hist/history.csv" "$@"
      '';
    in
    {
      programs.kickoff = {
        enable = true;

        settings = {
          prompt = "";

          search.show_hidden_files = false;

          history.decrease_interval = 24;

          # From config.theme.colors; the trailing two hex digits are alpha.
          colors = {
            background = "${c.mSurface}aa";
            prompt = "${c.mPrimary}ff";
            text = "${c.mPrimary}ff"; # for search results
            text_query = "${c.mOnSurface}ff"; # for the search query
            text_selected = "${c.mOnSurface}ff"; # for the currently selected result
          };
        };
      };

      home.packages = [ launcher ];
    };

  flake.nixosModules.kickoff = { ... }: {
    home-manager.sharedModules = [ self.modules.homeManager.kickoff ];
  };
}
