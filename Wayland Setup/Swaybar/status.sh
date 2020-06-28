# The Sway configuration file in ~/.config/sway/config calls this script.
# You should see changes to the status bar after saving this script.
# If not, do "killall swaybar" and $mod+Shift+c to reload the configuration.

# Produces "21 days", for example
uptime_formatted=$(uptime | cut -d ',' -f1  | cut -d ' ' -f4,5)

ram_usage=$(free -t | awk 'NR == 2 {printf("%.d%"), $3/$2*100}')
swap_usage=$(free -t | awk 'NR == 3 {printf(" %.2f%"), $3/$2*100}')
cpu_load=$(top -n 1 -b | awk '/^%Cpu/{print $2}')
cpu_fan=$(cat /sys/class/hwmon/hwmon2/fan1_input)
cpu_temp=$(cat /sys/class/hwmon/hwmon0/temp1_input | grep -Po '.*(?=...$)')

gpu_usage=$(cat /sys/class/drm/card0/device/gpu_busy_percent)
gpu_temp=$(cat /sys/class/hwmon/hwmon3/temp1_input | grep -Po '.*(?=...$)')
gpu_fan=$(cat /sys/class/hwmon/hwmon2/fan2_input)
gpu_vram_mb=$(cat /sys/class/drm/card0/device/mem_info_vram_used | grep -Po '.*(?=......$)')

# The abbreviated weekday (e.g., "Sat"), followed by the ISO-formatted date
# like 2018-10-06 and the time (e.g., 14:01)
date_formatted=$(date "+%A %d %B %Y %H:%M")
time_utc=$(date -u "+%H:%M")
# Get the Linux version but remove the "-1-ARCH" part
linux_version=$(uname -r | cut -d '-' -f1)

volume=$(pactl list sinks | grep Volume | head -n1 | awk '{print $5}')
audio_info=$(pactl list sinks | grep Mute | awk -v vol="${volume}" '{print $2=="no"? "🔉 " vol : "🔇 " vol}')

kb_layout=$(swaymsg -t get_inputs | jq '.[] | select(.identifier == "6700:19550:SEMICO_USB_Keyboard") | .xkb_active_layout_name' | head -n 1| tail -c +2 | head -c -2)

ssid=$(iwgetid wlan0 -r)


# Emojis and characters for the status bar
# 💎 💻 💡 🔌 ⚡ 📁 ⌨️   \|
echo RAM: $ram_usage "|" SWAP: $swap_usage "|" VRAM: $gpu_vram_mb MB " " CPU: $cpu_load @ $cpu_temp°C @ $cpu_fan rpm "	" GPU: $gpu_usage% @ $gpu_temp°C @ $gpu_fan rpm "		" 🐧 $linux_version " " 🖧 $ssid " " ⌨️ $kb_layout " " $audio_info $date_formatted " "UTC: $time_utc
