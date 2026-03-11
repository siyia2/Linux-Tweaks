#!/bin/sh

# Place the file under /usr/lib/systemd/system-sleep/ and mark it as executable
case "$1" in
  post)
    # After resume, signal Waybar as your user
    su $USER -c "pkill -SIGUSR2 waybar"
    ;;
esac

