# modules/desktop/default.nix
{ self, ... }: {
  # Home side: everything the user gets for the desktop
  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      niri
      kitty
      kickoff
      noctalia
    ];
  };

  # System side: only niri has a NixOS half
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      niri
    ];
  };
}
