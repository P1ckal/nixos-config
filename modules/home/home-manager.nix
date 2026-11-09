{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [ self.modules.homeManager.launcher-options ];
      users.sevyn.home.stateVersion = "26.05";
    };
  };
}
