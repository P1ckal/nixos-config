{ ... }:
{
  flake.nixosModules.git = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.lfs.enable = true;
    home.packages = [ pkgs.delta ];

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
        
        
      }
    ];
  };
}
