#!/usr/bin/bash
cpu_fan=$(cat /sys/class/hwmon/hwmon2/fan1_input)
echo "$cpu_fan"
exit
