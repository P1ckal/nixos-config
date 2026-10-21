# modules/desktop/default.nix
{ self, ... }: {
  # Home side: everything the user gets for the desktop
  flake.modules.homeManager.shell = {
    imports = with self.modules.homeManager; [
      niri
      kitty
      kickoff
      noctalia
    ];
  };

  # System side: only niri has a NixOS half
  flake.nixosModules.shell = {
    imports = with self.nixosModules; [
      niri
    ];
  };
}
