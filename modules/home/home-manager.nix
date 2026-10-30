{ inputs, ... }: {
  flake.nixosModules.home-manager = { ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.p1ckal.home.stateVersion = "26.05";
    };
  };
}
