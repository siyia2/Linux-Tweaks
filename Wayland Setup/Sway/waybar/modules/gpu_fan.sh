#!/bin/bash
gpu_fan=$(cat /sys/class/hwmon/hwmon3/fan1_input)
echo "$gpu_fan"
exit
