{ ... }: {
  flake.modules.homeManager.clipboard = { pkgs, ... }: {
    home.packages = [ pkgs.wl-clipboard ];
    services.cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}
