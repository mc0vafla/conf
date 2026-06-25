{config, ...}: {
  hardware = {
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    ksm.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      nvidiaPersistenced = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        sync.enable = true;
        offload.enable = false;
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  powerManagement.cpuFreqGovernor = "performance";
}
