{lib, ...}: {
  environment = {
    sessionVariables = {
      XCURSOR_THEME = "Breeze_Light";
      XCURSOR_SIZE = "26";
      XCURSOR_PATH = lib.mkForce "/run/current-system/sw/share/icons:~/.icons:~/.local/share/icons";
      XDG_CURRENT_DESKTOP = "niri";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_GFX = "1";
      NIXOS_OZONE_GL = "1";
    };
    variables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
    };
  };

  environment.etc."X11/cursors/Breeze_Light.theme".text = ''
    [Icon Theme]
    Inherits=Breeze_Light
  '';

  environment.variables.XCURSOR_THEME = "Breeze_Light";

  nix.settings = {
    accept-flake-config = true;
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    trusted-users = ["root" "mark"];
    http-connections = 128;
    max-substitution-jobs = 128;
    system-features = ["nixos-test" "benchmark" "big-parallel" "kvm"];
    download-buffer-size = 67108864;
    max-jobs = "auto";
    cores = 0;
  };
}
