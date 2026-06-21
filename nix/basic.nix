{
  lib,
  pkgs,
  ...
}: {
  services.displayManager.sddm = {
    enable = true;
    theme = lib.mkForce "${./sddm}";
    wayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = ["gnome"];
    };
  };

  documentation.enable = false;

  systemd = {
    services.systemd-user-sessions = {
      after = ["remote-fs.target"];
    };
    services.NetworkManager-wait-online.enable = false;
    services.lactd = {
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${pkgs.lact}/bin/lact daemon";
        Restart = "always";
      };
    };
    coredump.enable = false;
  };
}
