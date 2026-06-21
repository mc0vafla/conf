{pkgs, ...}: {
  systemd.user.services = {
    pipewire.environment.PIPEWIRE_DEBUG = "2";
    pipewire-pulse.environment.PIPEWIRE_DEBUG = "2";
  };

  programs.nix-ld.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 100;
    priority = 100;
  };

  users.users.root.shell = pkgs.fish;

  programs.fish = {
    enable = true;
    shellAliases = {};
  };

  system.activationScripts.linkRootConfigs = {
    text = ''
      rm -rf /root/.config/nvim /root/.local/share/nvim /root/.local/state/nvim /root/.cache/nvim
      rm -rf /root/.config/fish /root/.local/share/fish
      mkdir -p /root/.config /root/.local/share /root/.local/state /root/.cache
      ln -sfn /home/mark/.config/nvim /root/.config/nvim
      ln -sfn /home/mark/.local/share/nvim /root/.local/share/nvim
      ln -sfn /home/mark/.local/state/nvim /root/.local/state/nvim
      ln -sfn /home/mark/.cache/nvim /root/.cache/nvim
    '';
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "26.05";
}
