{ ... }:
{
  flake.nixosModules.git = { pkgs, ... }: {
    programs.git.enable = true;
    programs.git.lfs.enable = true;

    programs.git.config = [
      {
        init = {
          defaultBranch = "main";
        };
        
      }
    ];
  };
}
