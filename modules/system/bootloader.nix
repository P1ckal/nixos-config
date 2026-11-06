{...}: {
  # Define flake part nixosModule "bootloader" and pass in pkgs
  flake.nixosModules.bootloader = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [ sbctl ];
    # Normal nix code
    boot = {
      loader = {
        # Set bootloader timeout
        timeout = 2;
        efi = {
          # Enable efi var mutation
          canTouchEfiVariables = true;
        };
        # Enable grub
        limine = {
          enable = true;
          secureBoot.enable = true;
        };
      };

      # Set kernel to latest available version
      kernelPackages = pkgs.linuxPackages_latest;
    };
  };
}
