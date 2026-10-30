{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.p1ckal = {
        # The list of home pieces your user gets
        imports = with self.modules.homeManager; [
          desktop
          shell
          minecraft
        ];
        home.stateVersion = "26.05";
      };
    };
  };
}
