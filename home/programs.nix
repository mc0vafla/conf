{...}: {
  programs = {
    niri.enable = true;
    direnv = {
      enable = true;
      silent = true;
    };
    ydotool.enable = false;
    nix-index = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };
    command-not-found.enable = false;
    nix-index-database.comma.enable = true;
    nh = {
      enable = true;
      flake = "/etc/nixos";
    };
    dconf.enable = true;
    firefox.enable = false;
    fuse.userAllowOther = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
