{ ... }: {
  flake.nixosModules.zip = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.zip pkgs.unzip ];
  };
}
