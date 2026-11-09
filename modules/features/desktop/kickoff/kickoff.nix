{ ... }: {
  flake.modules.homeManager.kickoff =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      entriesFile = pkgs.writeText "kickoff-entries" (
        lib.concatStringsSep "\n" (
          lib.mapAttrsToList (name: cmd: "${name} = ${cmd}") config.launcher.entries
        )
        + "\n"
      );

      launcher = pkgs.writeShellScriptBin "launcher" ''
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

          colors = {
            # somehow this needs to actually take from the noctalia colors...
            background = "#1a0f16aa";
            prompt = "#ff8cb3ff";
            text = "#ff8cb3ff"; # for search results
            text_query = "#7897b3ff"; # for the search query
            text_selected = "#7897b3ff"; # for the currently selected result
          };
        };
      };

      home.packages = [ launcher ];
    };
}
