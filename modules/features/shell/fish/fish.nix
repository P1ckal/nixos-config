{ self, ... }: {
  flake.wrappers.fish =
    {
      config,
      lib,
      wlib,
      ...
    }:
    let
      t = config.theme.colors.terminal;

      # fish takes hex without the leading '#'
      hex = lib.removePrefix "#";
      n = name: hex t.normal.${name};
      b = name: hex t.bright.${name};

      colors = {
        # syntax highlighting
        fish_color_normal = "normal";
        fish_color_command = n "magenta";
        fish_color_keyword = n "magenta";
        fish_color_end = n "magenta";
        fish_color_param = n "blue";
        fish_color_option = n "blue";
        fish_color_quote = n "green";
        fish_color_comment = n "yellow";
        fish_color_error = n "red";
        fish_color_escape = n "cyan";
        fish_color_operator = n "cyan";
        fish_color_redirection = n "cyan";
        fish_color_autosuggestion = b "black";
        fish_color_valid_path = "--underline=single";
        fish_color_cancel = "--reverse";
        fish_color_history_current = "--bold";
        fish_color_selection = "${hex t.selectionFg} --bold --background=${hex t.selectionBg}";
        fish_color_search_match = "${hex t.selectionFg} --bold --background=${hex t.selectionBg}";

        # prompt pieces (only used if something uses the stock prompt helpers)
        fish_color_cwd = n "green";
        fish_color_cwd_root = n "red";
        fish_color_user = b "green";
        fish_color_host = "normal";
        fish_color_host_remote = n "yellow";
        fish_color_status = n "red";

        # completion pager
        fish_pager_color_completion = "normal";
        fish_pager_color_description = n "yellow";
        fish_pager_color_prefix = "normal --bold --underline=single";
        fish_pager_color_progress = "${b "white"} --bold --background=${n "cyan"}";
        fish_pager_color_selected_background = "--background=${hex t.selectionBg}";
      };

      themeLines = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "set --global ${name} ${value}") colors
      );
    in
    {
      imports = [
        wlib.wrapperModules.fish
        self.modules.generic.theme
      ];

      plugins = [ ];

      # unset private mode so history works
      configFile.content = ''
        set -e fish_private_mode
        set -g fish_history fish
        ${themeLines}
      '';

      shellAliases = lib.mapAttrs (_: lib.mkDefault) {
      };
    };
  flake.nixosModules.fish =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      base = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
      fish = base.wrap (config.my.fish.modules);
    in
    {
      options.my.fish.modules = lib.mkOption {
        type = lib.types.listOf lib.types.deferredModule;
        default = [ ];
      };
      config = {
        programs.fish = {
          enable = true;
          package = fish;
        };
        users.users.sevyn.shell = fish;
      };
    };
}
