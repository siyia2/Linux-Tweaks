#!/bin/bash
gpu_temp=$(less /sys/class/hwmon/hwmon3/temp1_input | grep -Po '.*(?=...$)')
echo "$gpu_temp"
