# modules/theme/_palettes/catppuccin.nix
#
# Example second palette: Catppuccin (dark = Mocha, light = Latte).
# The file name (minus .nix) is the palette's name, i.e. `theme.name = "catppuccin"`.
#
# To add your own palette, copy this file, rename it, and change the colors.
# Every token below must be present in both `dark` and `light`; noctalia reads
# them directly (this whole attrset is written out as a noctalia custom
# palette), and the other modules expect all of them to exist.
#
# Token cheat sheet:
#   mPrimary / mSecondary / mTertiary   accents
#   mSurface / mSurfaceVariant          backgrounds (variant = raised/inactive)
#   mOnSurface / mOnSurfaceVariant      text on those backgrounds
#   mOnPrimary (etc.)                   text on top of that accent
#   mError                              urgent / error
#   mOutline                            subdued borders, inactive indicators
#   mShadow                             shadows
#   mHover / mOnHover                   hover highlight and its text
#   terminal.*                          ANSI colors, cursor, selection
{
  dark = {
    mPrimary = "#cba6f7"; # mauve
    mOnPrimary = "#11111b"; # crust
    mSecondary = "#89b4fa"; # blue
    mOnSecondary = "#11111b";
    mTertiary = "#f5c2e7"; # pink
    mOnTertiary = "#11111b";
    mError = "#f38ba8"; # red
    mOnError = "#11111b";
    mSurface = "#1e1e2e"; # base
    mOnSurface = "#cdd6f4"; # text
    mSurfaceVariant = "#313244"; # surface0
    mOnSurfaceVariant = "#a6adc8"; # subtext0
    mOutline = "#6c7086"; # overlay0
    mShadow = "#11111b"; # crust
    mHover = "#f5c2e7";
    mOnHover = "#11111b";
    terminal = {
      normal = {
        black = "#45475a"; # surface1
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#bac2de"; # subtext1
      };
      bright = {
        black = "#585b70"; # surface2
        red = "#f38ba8";
        green = "#a6e3a1";
        yellow = "#f9e2af";
        blue = "#89b4fa";
        magenta = "#f5c2e7";
        cyan = "#94e2d5";
        white = "#a6adc8"; # subtext0
      };
      foreground = "#cdd6f4";
      background = "#1e1e2e";
      cursor = "#f5e0dc"; # rosewater
      cursorText = "#1e1e2e";
      selectionFg = "#cdd6f4";
      selectionBg = "#585b70";
    };
  };

  light = {
    mPrimary = "#8839ef"; # mauve
    mOnPrimary = "#eff1f5"; # base
    mSecondary = "#1e66f5"; # blue
    mOnSecondary = "#eff1f5";
    mTertiary = "#ea76cb"; # pink
    mOnTertiary = "#eff1f5";
    mError = "#d20f39"; # red
    mOnError = "#eff1f5";
    mSurface = "#eff1f5"; # base
    mOnSurface = "#4c4f69"; # text
    mSurfaceVariant = "#ccd0da"; # surface0
    mOnSurfaceVariant = "#6c6f85"; # subtext0
    mOutline = "#9ca0b0"; # overlay0
    mShadow = "#dce0e8"; # crust
    mHover = "#ea76cb";
    mOnHover = "#eff1f5";
    terminal = {
      normal = {
        black = "#5c5f77"; # subtext1
        red = "#d20f39";
        green = "#40a02b";
        yellow = "#df8e1d";
        blue = "#1e66f5";
        magenta = "#ea76cb";
        cyan = "#179299";
        white = "#acb0be"; # surface2
      };
      bright = {
        black = "#6c6f85"; # subtext0
        red = "#d20f39";
        green = "#40a02b";
        yellow = "#df8e1d";
        blue = "#1e66f5";
        magenta = "#ea76cb";
        cyan = "#179299";
        white = "#bcc0cc"; # surface1
      };
      foreground = "#4c4f69";
      background = "#eff1f5";
      cursor = "#dc8a78"; # rosewater
      cursorText = "#eff1f5";
      selectionFg = "#4c4f69";
      selectionBg = "#acb0be";
    };
  };
}
