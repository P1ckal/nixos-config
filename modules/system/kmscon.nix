{...}: {
  flake.nixosModules.kmscon = {pkgs, ...}: {
    services.kmscon = {
      enable = true;
      hwRender = true;

      extraConfig = "
        font-size=16
      ";
        
    };
  };
}
