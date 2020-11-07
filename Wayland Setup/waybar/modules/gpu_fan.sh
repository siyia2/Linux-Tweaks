#!/bin/bash
gpu_fan=$(less /sys/class/hwmon/hwmon2/fan2_input)
echo "$gpu_fan"
