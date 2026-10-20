{...}: {
  # Define flake part nixosModule "user"
  flake.nixosModules.user = {...}: {
    # Normal nix code
    # Define user called user01
    users.users.user01 = {
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
