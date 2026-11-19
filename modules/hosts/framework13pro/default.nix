{
  # Import self and universal inputs (different to inputs')
  self,
  inputs,
  ...
}:
{
  # Define nixosConfiguration with hostname "host"
  flake.nixosConfigurations.framework13pro = inputs.nixpkgs.lib.nixosSystem {
    # Define modules to import
    modules = with self.nixosModules; [
      hostConfiguration
      hostDisk
      system
      laptop
      home-manager
      shell
      desktop
      tofi
      zen-browser
      discord
      minecraft
      steam
      java-dev
      nix-dev
      game-design
      python-dev
      tailscale

      {
        theme.name = "pixel-purple";
        my.niri.modules = [
          {
            settings.outputs."eDP-1" = {
              mode = "2880x1920@120";
              scale = 1.5;
            };
          }
        ];
      }
    ];

  };
}
