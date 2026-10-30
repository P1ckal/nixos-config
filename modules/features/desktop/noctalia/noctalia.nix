{ inputs, ... }: {
  flake.modules.homeManager.noctalia = { ... }: {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;

      # Enables NetworkManager, Bluetooth, Upower, powerprofile stuff. Good for now but may change idk.
      # recommendedServices.enable = true;
    };
    
    #home.packages = [
    #  inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #];
    xdg.configFile."noctalia" = {
      source = ./config;
      recursive = true;
    };
  };
}
