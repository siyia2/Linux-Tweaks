#!/bin/sh
case "$1" in
  post)
    # After resume, signal Waybar as your user
    su siyia -c "pkill -SIGUSR2 waybar"
    ;;
esac

