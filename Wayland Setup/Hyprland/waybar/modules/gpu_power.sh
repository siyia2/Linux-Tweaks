#!/bin/bash

gpu_power=$(cat /sys/class/drm/card1/device/power_dpm_force_performance_level)

if [ "$gpu_power" = "low" ]; then
    echo "🌱"
else
    echo "🚀"
fi
