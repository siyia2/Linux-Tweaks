#!/bin/bash
gpu_fan=$(cat /sys/class/hwmon/hwmon2/fan2_input)
echo "$gpu_fan"
exit
