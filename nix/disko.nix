{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                extraArgs = ["-n" "BOOT"];
                mountOptions = ["noatime" "nofail" "fmask=0077" "dmask=0077" "errors=remount-ro"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f" "-L" "root-pool"];
                subvolumes = {
                  "root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "ssd" "noatime" "discard=async"];
                  };
                  "nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "ssd" "noatime" "discard=async" "space_cache=v2" "commit=120"];
                  };
                  "swap" = {
                    mountpoint = "/var/swap";
                  };
                };
              };
            };
          };
        };
      };
      data-disk = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            data = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f" "-L" "data"];
                subvolumes = {
                  "data" = {
                    mountpoint = "/mnt/data";
                    mountOptions = ["compress=zstd" "nofail" "noatime" "discard=async"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
