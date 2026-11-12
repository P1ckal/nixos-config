{ ... }: {
  flake.modules.homeManager.ruff = { ... }: {
    programs.ruff = {
      enable = true;
    };
  };
}
