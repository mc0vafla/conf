{pkgs, ...}: let
  r2modmanAppImage = pkgs.fetchurl {
    url = "https://github.com/ebkr/r2modmanPlus/releases/download/v3.2.17/r2modman-3.2.17.AppImage";
    sha256 = "sha256-iqnh9OQeNDUEnEdko2Tec0ZA+u457h06TUtwhUoFkxw=";
  };
in {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "r2modman" ''
      export DBUS_SESSION_BUS_ADDRESS=/dev/null
      TMP_APP=$(mktemp)
      cp ${r2modmanAppImage} $TMP_APP
      chmod +x $TMP_APP
      export GDK_BACKEND=x11
      export QT_QPA_PLATFORM=xcb

      ${pkgs.appimage-run}/bin/appimage-run $TMP_APP \
        --disable-gpu \
        --no-sandbox \
        --disable-software-rasterizer \
        "$@"
    '')
  ];
}
