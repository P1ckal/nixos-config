{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { config, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.theme
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = with self.modules.homeManager; [
        launcher-options
        theme
        { theme = { inherit (config.theme) name mode; }; }
      ];
      users.sevyn.home.stateVersion = "26.05";
    };
  };
}
