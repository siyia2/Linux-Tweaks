#!/bin/bash

# Get the mute status of the microphone
status=$(pactl get-source-mute alsa_input.pci-0000_00_14.2.analog-stereo | awk '{print $2}')

# Determine the icon based on the status
if [ "$status" == "yes" ]; then
  echo "🔴"
else
  echo "🟢"
fi

