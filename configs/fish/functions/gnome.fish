function gnome --wraps='XDG_SESSION_TYPE=wayland dbus-run-session gnome-session' --wraps='XDG_SESSION_TYPE=wayland gnome-shell --wayland' --description 'alias gnome=XDG_SESSION_TYPE=wayland gnome-shell --wayland'
    XDG_SESSION_TYPE=wayland gnome-shell --wayland $argv
end
