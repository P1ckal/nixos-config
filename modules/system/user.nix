{...}: {
  # Define flake part nixosModule "user"
  flake.nixosModules.user = {...}: {
    # Normal nix code
    # Define user called p1ckal
    users.users.p1ckal = {
      # Make not root explicitly (prevents permission issues)
      isNormalUser = true;
      # Password for vm
      initialPassword = "pass";
      # Allow use of sudo with password
      extraGroups = [
        "root"
        "wheel"
      ];
    };
  };
}
