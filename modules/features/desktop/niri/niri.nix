{ ... }:
{
  flake.nixosModules.niri = { pkgs, ... }: {
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [ xwayland-satellite ];
  };

  flake.modules.homeManager.niri = { config, lib, pkgs, ... }:
    let
      c = config.theme.colors;

      # Nix doesn't re-indent interpolated multi-line strings, so nest them by hand.
      indent = n: s:
        lib.concatStringsSep "\n${lib.concatStrings (lib.replicate n " ")}" (
          lib.splitString "\n" (lib.removeSuffix "\n" s)
        );

      # Shared by both generated files below.
      tabIndicator = ''
        tab-indicator {
            active-color   "${c.mPrimary}"
            inactive-color "${c.mOutline}"
            urgent-color   "${c.mError}"
        }
      '';

      # Included from config.kdl. Same structure as noctalia's niri template,
      # plus the shadow color.
      noctaliaKdl = pkgs.writeText "noctalia.kdl" ''
        layout {

            focus-ring {
                active-color   "${c.mPrimary}"
                inactive-color "${c.mSurface}"
                urgent-color   "${c.mError}"
            }

            border {
                active-color   "${c.mPrimary}"
                inactive-color "${c.mSurface}"
                urgent-color   "${c.mError}"
            }

            shadow {
                color "${c.mShadow}70"
            }

            ${indent 4 tabIndicator}

            insert-hint {
                color "${c.mPrimary}80"
            }
        }

        recent-windows {
            highlight {
                active-color "${c.mPrimary}"
                urgent-color "${c.mError}"
            }
        }
      '';

      # Included after noctalia.kdl, so its gradient wins over active-color
      # and its tab-indicator wins over the one above.
      focusRingKdl = pkgs.writeText "focus-ring.kdl" ''
        layout {
          focus-ring {
            active-gradient from="${c.mSurface}" to="${c.mPrimary}" angle=135
          }

          ${indent 2 tabIndicator}
        }
      '';

      # config.kdl `include`s its siblings by relative path, so the generated
      # files must sit in the same store directory as config.kdl. Building one
      # combined directory guarantees that however niri resolves symlinks.
      niriConfig = pkgs.runCommand "niri-config" { } ''
        cp -r ${./config} $out
        chmod -R u+w $out
        cp ${noctaliaKdl} $out/noctalia.kdl
        cp ${focusRingKdl} $out/focus-ring.kdl
      '';
    in
    {
      xdg.configFile."niri" = {
        source = niriConfig;
        recursive = true;
      };
    };
}
