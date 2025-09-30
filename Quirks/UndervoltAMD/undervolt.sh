#! /bin/sh

#echo 100000000 > /sys/class/drm/card0/device/hwmon/hwmon3/power1_cap
echo 100000000 > /sys/class/drm/card1/device/hwmon/hwmon3/power1_cap
echo "manual" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level
echo "low" | sudo tee /sys/class/drm/card1/device/power_dpm_force_performance_level
exit
