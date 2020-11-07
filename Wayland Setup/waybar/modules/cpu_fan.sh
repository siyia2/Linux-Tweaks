#!/usr/bin/bash
cpu_fan=$(less /sys/class/hwmon/hwmon2/fan1_input)
echo "$cpu_fan"
