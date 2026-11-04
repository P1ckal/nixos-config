{ inputs, ... }: {
  flake.nixosModules.hostDisk = { lib, ...}: let
    resumeOffset = 533760;
  in {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-KLEVV_CRAS_C925G_M.2_NVMe_SSD_1TB_2026011311002358";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings = {
                allowDiscards = true;      # TRIM through LUKS
                bypassWorkqueues = true;   # better SSD/NVMe performance
              };
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/log" = {
                    mountpoint = "/var/log";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/snapshots" = {
                    mountpoint = "/.snapshots";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/swap" = {
                    mountpoint = "/.swapvol";
                    swap.swapfile.size = "32G";   # set this to at least your RAM size
                  };
                };
              };
            };
          };
        };
      };
    };

    services.btrfs.autoScrub.enable = true;   # periodic integrity check
    boot.resumeDevice = lib.mkIf (resumeOffset != null) "/dev/mapper/cryptroot";
    boot.kernelParams = lib.optional (resumeOffset != null)
    "resume_offset=${toString resumeOffset}";  };
}
