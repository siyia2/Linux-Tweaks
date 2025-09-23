99;6u#!/bin/bash
gpu_usage=$(cat /sys/class/drm/card1/device/gpu_busy_percent)
echo "$gpu_usage"
exit
