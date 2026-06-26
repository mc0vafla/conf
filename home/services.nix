{pkgs, ...}: {
  services = {
    zfs = {
      autoScrub = {
        enable = true;
        interval = "weekly";
      };
      trim.enable = true;
    };
    flatpak = {
      enable = true;
      packages = [
        "com.valvesoftware.Steam"
        "com.heroicgameslauncher.hgl"
      ];
    };
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
    dbus.implementation = "broker";
    earlyoom = {
      enable = true;
      enableNotifications = false;
      freeMemThreshold = 5;
      freeSwapThreshold = 5;
    };
    udisks2.enable = true;
    gvfs.enable = true;
    printing.enable = false;
    upower.enable = true;
    fstrim.enable = true;
    power-profiles-daemon.enable = true;
    logind.settings.Login.KillUserProcesses = true;

    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
      extraCgroups = [
        {name = "cpu";}
        {name = "io";}
        {name = "memory";}
      ];
    };

    gnome = {
      gnome-keyring.enable = true;
      core-apps.enable = false;
    };
    desktopManager.gnome.enable = false;
  };
}
