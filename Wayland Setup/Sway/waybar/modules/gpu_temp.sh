#!/bin/bash
gpu_temp=$(cat /sys/class/drm/card0/device/hwmon/hwmon3/temp2_input | grep -Po '.*(?=...$)')
echo "$gpu_temp"
exit
