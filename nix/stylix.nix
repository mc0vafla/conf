{
  config,
  pkgs,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";
    polarity = "dark";
    image = ./configs/Wallpapers/stylix.png;
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };
    autoEnable = true;
  };
  environment.variables.PAPIRUS_FOLDERS = "green";

  environment.etc."xdg/kitty/kitty.conf".text = ''
    background              #${config.lib.stylix.colors.base00}
    foreground              #${config.lib.stylix.colors.base05}
    selection_foreground    #${config.lib.stylix.colors.base00}
    selection_background    #${config.lib.stylix.colors.base05}
    active_border_color     #${config.lib.stylix.colors.base0D}
    inactive_border_color   #${config.lib.stylix.colors.base03}

    window_padding_width      15
    tab_bar_style             powerline
    active_tab_foreground     #${config.lib.stylix.colors.base00}
    active_tab_background     #${config.lib.stylix.colors.base0D}
    inactive_tab_foreground   #${config.lib.stylix.colors.base05}
    inactive_tab_background   #${config.lib.stylix.colors.base01}

    cursor                    #${config.lib.stylix.colors.base05}
    cursor_text_color         #${config.lib.stylix.colors.base00}
    cursor_shape              beam
    cursor_trail              3
    cursor_trail_decay        0.1 0.4
    url_color                 #${config.lib.stylix.colors.base0D}

    # normal
    color0  #${config.lib.stylix.colors.base00}
    color1  #${config.lib.stylix.colors.base08}
    color2  #${config.lib.stylix.colors.base0B}
    color3  #${config.lib.stylix.colors.base0A}
    color4  #${config.lib.stylix.colors.base0D}
    color5  #${config.lib.stylix.colors.base0E}
    color6  #${config.lib.stylix.colors.base0C}
    color7  #${config.lib.stylix.colors.base05}

    # bright
    color8  #${config.lib.stylix.colors.base03}
    color9  #${config.lib.stylix.colors.base09}
    color10 #${config.lib.stylix.colors.base01}
    color11 #${config.lib.stylix.colors.base02}
    color12 #${config.lib.stylix.colors.base04}
    color13 #${config.lib.stylix.colors.base06}
    color14 #${config.lib.stylix.colors.base0F}
    color15 #${config.lib.stylix.colors.base07}

    background_opacity        0.90
    background_blur           20
    repaint_delay             8
    input_delay               2
    sync_to_monitor           yes
    confirm_os_window_close   0
    allow_remote_control      yes
    listen_on                 unix:/tmp/mykitty
    remember_window_size      yes
    wayland_titlebar_color    background

    enabled_layouts splits,stack,fat,tall
    map ctrl+shift+i launch --location=hsplit
    map ctrl+shift+u launch --location=vsplit
    map ctrl+shift+h neighboring_window left
    map ctrl+shift+l neighboring_window right
    map ctrl+shift+k neighboring_window up
    map ctrl+shift+j neighboring_window down
  '';
}
