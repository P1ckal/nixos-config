{ ... }: {
  flake.nixosModules.forgejo = { pkgs, ... }: {
    programs.git.lfs.enable = true;
  };
}
