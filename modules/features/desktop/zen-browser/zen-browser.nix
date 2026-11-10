{ inputs, ... }: {
  flake.modules.homeManager.zen-browser = { config, lib, ... }: {
    launcher.entries."Zen" = lib.getExe config.programs.zen-browser.finalPackage;

    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      policies =
        let
          mkExtensionSettings = builtins.mapAttrs (
            _: pluginId: {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
              installation_mode = "force_installed";
            }
          );
        in
        {
          DisableAppUpdate = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          EnableTrackingPrevention = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };

          # extensionsettings = mkextensionsettings {
          #   "wappalyzer@crunchlabz.com" = "wappalyzer";
          #   "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          # };

          "3rdparty".Extensions."uBlock0@raymondhill.net".toOverwrite = {
            # Entries matching `scheme://` are also subscribed as external lists.
            filterLists = [
              "user-filters"
              "ublock-filters"
              "ublock-badware"
              "ublock-privacy"
              "ublock-quick-fixes"
              "ublock-unbreak"
              "adguard-spyware-url"
              "easylist"
              "adguard-generic"
              "adguard-mobile"
              "easyprivacy"
              "adguard-spyware-url"
            ];
            filters = [ ]; # dashboard: My filters
            trustedSiteDirectives = [ ]; # dashboard: Trusted sites
          };

        };

      profiles.default = {
        settings = {
          "zen.view.experimental-no-window-controls" = true;
        };

        # spacesForce = true; # delete spaces not declared
        spaces = {
          "Default" = {
            id = "01445b67-c990-4477-84f5-bb0f908887b0";
            position = 2000;

          };
          "School" = {
            id = "ba5f1efb-203f-4bee-91f4-3bd8d98ec35c";
            position = 3000;

          };
          "Programming" = {
            id = "eb3d9d90-5c2e-47d3-b7bf-24097000eae7";
            position = 4000;

          };
        };

        pinsForce = true;
        pinsForceAction = "remove";
        pins = {
          "Music" = {
            id = "fdd3fd0f-b954-4e12-8b3d-1fd29b2c589b";
            url = "https://music.youtube.com";
            position = 101;
            isEssential = true;
          };
        };

        search = {
          force = true;
          default = "google";
          engines = {
            minecraft = {
              name = "Minecraft Wiki";
              definedAliases = [ "@mc" ];
              icon = ./icons/MinecraftWiki.webp;
              urls = [
                {
                  template = "https://minecraft.wiki/?search={searchTerms}";
                  params = [
                    {
                      name = "query";
                      value = "searchTerms";
                    }
                  ];
                }
              ];
            };
          };
        };
      };
    };

  };
}
