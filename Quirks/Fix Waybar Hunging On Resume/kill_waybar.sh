#!/bin/bash
case $1/$2 in
  pre/*)
    killall waybar
    ;;
  post/*)
    # Run waybar as the user in their graphical session
esac
