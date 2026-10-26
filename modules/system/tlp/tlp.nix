{ ... }:
{
  flake.nixosModules.tlp = { pkgs, ... }: {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "balanced";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balanced";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        # Battery charge thresholds (optional, hardware-dependent)
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
