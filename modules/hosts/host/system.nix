{...}: {
  # Define flake part nixosModule "hostConfiguration" and pass in arch specific pkgs
  flake.nixosModules.hostConfiguration = {pkgs, ...}: {
    # Normal nix code within module, add git to systemPackages
    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      git
      hyfetch
      fastfetch
      xwayland-satellite
    ];

    # w gpu acceleration
    virtualisation.vmVariant.virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display gtk,gl=on"
    ];
  };
}
