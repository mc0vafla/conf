{
  pkgs,
  stable,
  ...
}: let
  unstablePackages = with pkgs; [
    zen-browser
    helium
    noctalia-qs
    noctalia-shell
  ];

  stablePackages = with stable; [
    nix-init
    vscode-langservers-extracted
    nodejs_22
    gcc
    gnumake
    tint
    prismlauncher
    deadnix
    yazi
    cmatrix
    fuzzel
    tenki
    tree-sitter
    xwayland-satellite
    xwayland
    telegram-desktop
    vesktop
    nvd
    alejandra
    appimage-run
    zoxide
    pcmanfm-qt
    nwg-look
    hyprpicker
    pavucontrol
    faugus-launcher
    umu-launcher
    everforest-gtk-theme
    zip
    pinta
    transmission_4-gtk
    celluloid
    ncdu
    file-roller
    baobab
    kittysay
    cava
    onefetch
    dix
    fortune
  ];
in {
  environment.systemPackages = with stable; [
    (papirus-icon-theme.override {color = "green";})
    wl-clipboard
    git
    fzf
    fd
    lsd
    fastfetch
    btop
    dysk
    duf
    wget
    bat
    unzip
    killall
    kitty
    kdePackages.breeze-gtk
    kdePackages.breeze
    neovim
    ripgrep
    broot
    tre-command
    xrdb
    xsetroot
  ];

  users.users.mark = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["networkmanager" "wheel" "video" "render"];
    packages = stablePackages ++ unstablePackages;
  };
}
