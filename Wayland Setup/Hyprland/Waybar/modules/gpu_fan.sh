#!/bin/bash
gpu_fan=$(cat /sys/class/drm/card0/device/hwmon/hwmon3/fan1_input)
echo "$gpu_fan"
exit
