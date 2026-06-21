{...}: {
  networking.wireless.iwd.enable = true;
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
    wifi.backend = "iwd";
    unmanaged = ["interface-name:p2p-dev-*"];
    settings = {
      main = {
        "unmanaged-devices" = "interface-name:p2p-dev-*";
        "dns" = "default";
      };
      connectivity = {
        "enabled" = "false";
      };
    };
  };
}
