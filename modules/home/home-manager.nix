{ self, inputs, ... }: {
  flake.nixosModules.home-manager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.user01 = {
        # The list of home pieces your user gets
        imports = with self.modules.homeManager; [
          niri
        ];
        home.stateVersion = "26.05";
      };
    };
  };
}
