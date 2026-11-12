{ ... }: {
  flake.modules.homeManager.uv = { ... }: {
    programs.uv = {
      enable = true;
    };
  };
  flake.nixosModules.uv = { ... }: {
    environment.localBinInPath = true;
    programs.nix-ld.enable = true;
  };
}
