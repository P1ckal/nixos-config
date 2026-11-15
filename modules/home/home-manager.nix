{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = with self.modules.homeManager; [
        launcher-options
        theme
      ];
      users.sevyn.home.stateVersion = "26.05";
    };
  };
}
