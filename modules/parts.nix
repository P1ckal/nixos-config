{ inputs, ... }: {
  imports = [
    inputs.flake-parts.flakeModules.modules
    inputs.wrappers.flakeModules.wrappers
  ];

  config = {
    # Define what systems the modules are runnable on.
    # Some pacakges may not have an aarch64 version, consult
    # nixpkgs to check.
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];
  };
}
