{ ... }:
{
  flake.nixosModules.git = { pkgs, ... }: {
    programs.git.enable = true;
    home.packages = [ pkgs.delta ];
    services.gnome.gnome-keyring.enable = true;

    programs.git.config = [
      {
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

        credential.helper = "${pkgs.git.out}/bin/git-credential-libsecret";
        
        
      }
    ];
  };
}
