#!/bin/bash

# Get the mute status (more precise)
status=$(pactl get-source-mute alsa_input.pci-0000_0a_00.4.analog-stereo | awk '{print $2}')

if [ "$status" == "yes" ]; then
  echo "🟢"
else
  echo "🔴"
fi
