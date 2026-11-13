{ ... }: {
  flake.modules.homeManager.btop = { ... }: {
    programs.btop = {
      enable = true;
      settings = {
        
      };
      # need to add themes somehow (only config I see is a hell of a lot of manual lines)
    };
  };
}
