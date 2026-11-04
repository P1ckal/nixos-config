{...}: {
  # Define flake part nixosModule "hostConfiguration" and pass in arch specific pkgs
  flake.nixosModules.hostConfiguration = {pkgs, ...}: {
    imports = [./_hardware-configuration.nix];
    networking.hostName = "nixosfixesthis";
    system.stateVersion = "26.05";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    zramSwap.enable = true;
    hardware.enableRedistributableFirmware = true;
    hardware.graphics.enable = true;

    services.fprintd.enable = true;
    services.ntp.enable = true;
    time.timeZone = "EST5EDT";
    time.hardwareClockInLocalTime = true;
    # Normal nix code within module, add git to systemPackages
    environment.systemPackages = with pkgs; [
      git
    ];

    # w gpu acceleration
    virtualisation.vmVariant.virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];
  };
}
