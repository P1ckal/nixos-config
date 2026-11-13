{self, ...}: {
  flake.nixosModules.laptop = {...}: let
    modules = with self.nixosModules; [
      tlp
    ];
  in {
    imports = modules;
  };
}
