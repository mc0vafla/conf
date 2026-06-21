{...}: {
  flake.nixosModules.homeLinks = {...}: {
    systemd.user.services.link-user-configs = {
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        mkdir -p "$HOME/.config/pcmanfm-qt/default"
        mkdir -p "$HOME/Pictures"

        links=(
          "$HOME/.config/niri" "${./configs/niri}"
          "$HOME/.config/fish" "${./configs/fish}"
          "$HOME/.config/fastfetch" "${./configs/fastfetch}"
          "$HOME/.config/noctalia" "${./configs/noctalia}"
          "$HOME/.config/fetch" "${./configs/fetch}"
          "$HOME/.config/fuzzel" "${./configs/fuzzel}"
          "$HOME/.config/broot" "${./configs/broot}"
          "$HOME/.config/yazi" "${./configs/yazi}"
          "$HOME/.config/pcmanfm-qt/default/settings.conf" "${./configs/settings.conf}"
          "$HOME/.config/nwg-look" "${./configs/nwg-look}"
          "$HOME/Pictures/Wallpapers" "${./configs/Wallpapers}"
          "$HOME/heh" "${./configs/heh}"
        )
        for ((i=0; i<''${#links[@]}; i+=2)); do
          target="''${links[i]}"
          source="''${links[i+1]}"

          if [ -L "$target" ] || [ -e "$target" ]; then
            rm -rf "$target"
          fi

          ln -s "$source" "$target"
        done
      '';
    };
  };
}
