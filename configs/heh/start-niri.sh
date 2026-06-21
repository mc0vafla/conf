#!/usr/bin/env bash
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_TYPE=wayland
exec niri --session -- systemctl --user start niri-session.target
