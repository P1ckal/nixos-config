{ ... }: {
  flake.nixosModules.greetd =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      c = config.theme.colors;
      t = c.terminal;
      toml = pkgs.formats.toml { };

      hex = color: builtins.substring 1 6 color;

      # Override vt colors so we can have a better colored tuigreet.
      # May change later when kmscon support is better
      ttyColors = [
        (hex t.background) # 0: black
        (hex t.normal.red) # 1: red
        (hex t.normal.green) # 2: green
        (hex t.normal.yellow) # 3: yellow
        (hex t.normal.blue) # 4: blue
        (hex t.normal.magenta) # 5: magenta
        (hex t.normal.cyan) # 6: cyan
        (hex t.foreground) # 7: gray / white
        (hex c.mSurfaceVariant) # 8: darkgray
        (hex t.bright.red) # 9: lightred
        (hex t.bright.green) # A: lightgreen
        (hex t.bright.yellow) # B: lightyellow
        (hex t.bright.blue) # C: lightblue
        (hex t.bright.magenta) # D: lightmagenta
        (hex t.bright.cyan) # E: lightcyan
        (hex t.bright.white) # F: white
      ];

      hexIndices = [
        "0"
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "A"
        "B"
        "C"
        "D"
        "E"
        "F"
      ];

      setPaletteCmd = builtins.concatStringsSep "" (
        lib.zipListsWith (idx: col: "\\e]P${idx}${col}") hexIndices ttyColors
      );

      tuigreetConfig = toml.generate "tuigreet-config.toml" {

        display = {
          show_time = true;
          issue = false;
        };

        remember = {
          username = true;
        };

        session = {
          command = "niri-session";
        };

        background = {
          kind = "matrix";
          fps = 15;
          matrix = {
            head_color = c.mSurfaceVariant;
            bright_color = c.mSurfaceVariant;
            dim_color = c.mSurfaceVariant;
            # min_length = 6;
            # max_length = 18;
            # min_speed = 0.30;
            # max_speed = 1.10;
            mutate_chance = 0.00;
          };
        };

        theme = {
          container = "black";
          border = "magenta";
          title = "cyan";
          text = "magenta";
          greet = "green";
          time = "blue";
          prompt = "green";
          input = "white";
          action = "yellow";
          button = "magenta";
        };
      };

      tuigreetWrapper = pkgs.writeShellScript "tuigreet-wrapper" ''
        printf '${setPaletteCmd}'
        ${lib.getExe' pkgs.ncurses "clear"}

        ${lib.getExe pkgs.tuigreet} --config ${tuigreetConfig}
        status=$?

        printf '\e]R'
        ${lib.getExe' pkgs.ncurses "clear"}
        exit $status
      '';
    in
    {
      services.greetd = {
        enable = true;
        settings.default_session = {
          command = "${tuigreetWrapper}";
          user = "greeter";
        };
      };
    };
}
