#!/bin/bash
gpu_usage=$(cat /sys/class/drm/card0/device/gpu_busy_percent)
echo "$gpu_usage"
exit
