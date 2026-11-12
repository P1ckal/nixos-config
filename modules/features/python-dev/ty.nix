{ ... }: {
  flake.modules.homeManager.ty = { ... }: {
    programs.ty = {
      enable = true;
    };
  };
}
