{ ... }:
{
  flake.modules.homeManager.git = { ... }: {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };

  
  flake.nixosModules.git = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.package = pkgs.git.override { withLibsecret = true; };

    services.gnome.gnome-keyring.enable = true;
    environment.systemPackages = [ pkgs.libsecret ];

    programs.git.config = {
        core = {
          pager = "delta";
        };

        diff = {
          algorithm = "histogram";
        };
        
        init = {
          defaultBranch = "main";
        };

        merge = {
          conflictstyle = "zdiff3";
        };

        commit = {
          verbose = "true";
        };

        credential.helper = "libsecret";

      };
    
  };
}
