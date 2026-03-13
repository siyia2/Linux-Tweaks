#!/bin/sh
case "$1" in
  post)
    sleep 1
    pkill waybar
    sleep 2
    SWAYSOCK=$(ls /run/user/1000/sway-ipc.1000.*.sock 2>/dev/null | head -1)
    sudo -u siyia env \
      WAYLAND_DISPLAY=wayland-1 \
      DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus \
      XDG_RUNTIME_DIR=/run/user/1000 \
      SWAYSOCK=$SWAYSOCK \
      waybar &
    ;;
esac
