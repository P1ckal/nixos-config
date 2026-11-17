{ self, ... }: {
  flake.wrappers.btop =
    {
      config,
      lib,
      wlib,
      ...
    }:
    let
      c = config.theme.colors;
      t = c.terminal;
    in
    {
      imports = [
        wlib.wrapperModules.btop
        self.modules.generic.theme
      ];

      # move generated folder elsewhere bc i love my clean .config folder
      # using here bc it's what noctalia kinda uses as well so feels right
      env.XDG_CONFIG_HOME = "/var/empty";

      settings = lib.mapAttrs (_: lib.mkDefault) {
        color_theme = "nix-generated";
      };

      themes = lib.mapAttrs (_: lib.mkDefault) {
        nix-generated = ''
          theme[main_bg]="${c.mSurface}"
          theme[main_fg]="${c.mSurfaceVariant}"
          theme[title]="${t.normal.green}"
          theme[hi_fg]="${c.mHover}"
          theme[selected_bg]="${c.mOnSurface}"
          theme[selected_fg]="${c.mOnSurfaceVariant}"
          theme[inactive_fg]="${t.selectionFg}"
          theme[proc_misc]="${t.normal.yellow}"
          theme[cpu_box]="${c.mOutline}"
          theme[mem_box]="${c.mOutline}"
          theme[net_box]="${c.mOutline}"
          theme[proc_box]="${c.mOutline}"
          theme[div_line]="${c.mOutline}"
          theme[temp_start]="${t.normal.green}"
          theme[temp_mid]="${t.normal.yellow}"
          theme[temp_end]="${c.mHover}"
          theme[cpu_start]="${t.normal.green}"
          theme[cpu_mid]="${t.normal.yellow}"
          theme[cpu_end]="${c.mHover}"
          theme[free_start]="${t.normal.green}"
          theme[free_mid]="${t.normal.yellow}"
          theme[free_end]="${c.mHover}"
          theme[cached_start]="${t.normal.green}"
          theme[cached_mid]="${t.normal.yellow}"
          theme[cached_end]="${c.mHover}"
          theme[available_start]="${t.normal.green}"
          theme[available_mid]="${t.normal.yellow}"
          theme[available_end]="${c.mHover}"
          theme[used_start]="${t.normal.green}"
          theme[used_mid]="${t.normal.yellow}"
          theme[used_end]="${c.mHover}"
          theme[download_start]="${t.normal.green}"
          theme[download_mid]="${t.normal.yellow}"
          theme[download_end]="${c.mHover}"
          theme[upload_start]="${t.normal.green}"
          theme[upload_mid]="${t.normal.yellow}"
          theme[upload_end]="${c.mHover}"
        '';
      };
    };
  flake.modules.homeManager.btop = { pkgs, ... }: {
    home.packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.btop ];
  };
}
