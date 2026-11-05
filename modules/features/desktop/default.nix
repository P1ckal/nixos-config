{ self, ... }: {
  # Home side: everything the user gets for the desktop
  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      niri
      kitty
      kickoff
      noctalia
      zen-browser
      discord
    ];
    
  };

  # System side: only niri has a NixOS half
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      niri greetd
    ];
    home-manager.sharedModules = [ self.modules.homeManager.desktop ];
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.upower.enable = true;
  };
}
