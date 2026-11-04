{
  description = "some config";

  inputs = {
    # Latest stable nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Flake parts utils
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # W home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    
  };

  # Default import-tree output
  outputs = inputs:
  # Pass all inputs to outputs
    inputs.flake-parts.lib.mkFlake {
      # Call mkFlake from flake-parts module
      inherit inputs; # Inherit inputs (required to get correct arch for self')
    } (inputs.import-tree ./modules); # Pass in all modules using import-tree
}
