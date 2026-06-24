{
  pkgs,
  lib,
  ...
}: {
  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.forceImportRoot = false;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "8G";
    };

    kernel.sysctl = {
      "net.core.default_qdisc" = "cake";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 512;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.core_pattern" = "|/bin/false";
      "vm.swappiness" = 180;
      "vm.page-cluster" = 0;
      "vm.max_map_count" = 2147483642;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.vfs_cache_pressure" = 50;
      "vm.compaction_proactiveness" = 20;
    };

    kernelParams = [
      "acpi_no_watchdog"
      "transparent_hugepage=madvise"
      "mitigations=off"
      "consoleblank=0"
      "8250.nr_uarts=0"
      "loglevel=3"
      "nmi_watchdog=0"
      "nowatchdog"
      "nvidia_drm.modeset=1"
      "pcie_aspm=off"
      "nvidia_drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      "amd_pstate=active"
      "split_lock_detect=off"
      "scsi_mod.use_blk_mq=1"
      "elevator=none"
      "udev.log_level=3"
      "udev.children_max=60"
    ];

    blacklistedKernelModules = ["sp5100_tco" "iTCO_wdt" "iTCO_vendor_support"];

    loader.grub = {
      enable = true;
      theme = lib.mkForce ./grub;
      efiSupport = true;
      device = "nodev";
      configurationLimit = 10;
      extraConfig = ''
        insmod video_bochs
        insmod video_cirrus
        insmod gfxterm
        set gfxpayload=keep
      '';

      extraEntries = ''
        menuentry "Void Linux" --class void --class gnu-linux --class gnu --class os {
            insmod part_gpt
            insmod btrfs
            search --no-floppy --fs-uuid --set=root ff0d0760-b403-4485-b08a-47ba9d060715
            linux /boot/vmlinuz-6.18.36_1 root=UUID=ff0d0760-b403-4485-b08a-47ba9d060715 ro
            initrd /boot/initramfs-6.18.36_1.img
        }
        menuentry "Chimera Linux" --class chakra --class gnu-linux --class os {
            insmod part_gpt
            insmod fat
            search --no-floppy --fs-uuid --set=root 706A-9652
            linux /chimera/vmlinuz root=zfs:rpool/ROOT/chimera bootfs=rpool/ROOT/chimera rw quiet
            initrd /chimera/initrd.img
        }
      '';
    };

    initrd = {
      availableKernelModules = ["nvme" "ahci" "xor" "zstd"];
      compressor = "zstd";
      compressorArgs = ["-1"];
      kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
      verbose = false;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    extraModprobeConfig = ''
      options iwlwifi power_save=0
      blacklist wdat_wdt
      install wdat_wdt /bin/false
    '';
  };

  networking.hostId = "8425e349";
}
