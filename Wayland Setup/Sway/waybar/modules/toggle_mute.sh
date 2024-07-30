#!/bin/bash

# Get the current mute state of the default sink
sink_mute_state=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

# Toggle the mute state of the default sink
pactl set-sink-mute @DEFAULT_SINK@ toggle

# Set the mute state of the source to match the new state of the sink
#if [ "$sink_mute_state" = "yes" ]; then
#    pactl set-source-mute alsa_input.pci-0000_00_14.2.analog-stereo 0
#else
    pactl set-source-mute alsa_input.pci-0000_00_14.2.analog-stereo 1
#fi
