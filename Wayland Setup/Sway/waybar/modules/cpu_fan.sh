#!/usr/bin/bash
cpu_fan=$(cat /sys/class/hwmon/hwmon5/fan1_input)
echo "$cpu_fan"
exit
