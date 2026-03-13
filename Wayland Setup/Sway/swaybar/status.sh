#!/bin/sh
# Sway status bar script - optimized version with integer percentages

# --- System files (read once via shell builtins, no subshells) ---
read -r cpu_temp_raw   < /sys/class/hwmon/hwmon0/temp1_input
read -r cpu_fan        < /sys/class/hwmon/hwmon2/fan1_input
read -r gpu_usage      < /sys/class/drm/card1/device/gpu_busy_percent
read -r gpu_temp_raw   < /sys/class/hwmon/hwmon3/temp1_input
read -r gpu_fan        < /sys/class/drm/card1/device/hwmon/hwmon3/fan1_input
read -r vram_total     < /sys/class/drm/card1/device/mem_info_vram_total
read -r gpu_vram_mb    < /sys/class/drm/card1/device/mem_info_vram_used
read -r gpu_power_status < /sys/class/drm/card1/device/power_dpm_force_performance_level

# --- Arithmetic in shell (integers only) ---
cpu_temp=$(( cpu_temp_raw / 1000 ))
gpu_temp=$(( gpu_temp_raw / 1000 ))
vram_percent=$(( (gpu_vram_mb * 100 + vram_total / 2) / vram_total ))

# --- RAM/SWAP: single awk pass over free output, integers ---
read -r ram_usage swap_usage << EOF
$(free | awk '
  NR==2 { ram=int($3/$2*100 + 0.5) }
  NR==3 { swap=int($3/$2*100 + 0.5) }
  END   { print ram"%" , swap"%" }
')
EOF

# --- CPU load: read and round to integer ---
if [[ -f /tmp/cpu_prev ]]; then
    read -r _ prev_user prev_nice prev_system prev_idle rest < /tmp/cpu_prev
    read -r _ curr_user curr_nice curr_system curr_idle rest < /proc/stat
    
    active_old=$((prev_user + prev_system))
    active_new=$((curr_user + curr_system))
    total_old=$((prev_user + prev_nice + prev_system + prev_idle))
    total_new=$((curr_user + curr_nice + curr_system + curr_idle))
    
    if (( total_new > total_old )); then
        cpu_load=$(( 100 * (active_new - active_old) / (total_new - total_old) ))
    else
        cpu_load=0
    fi
else
    cpu_load=0
fi

# Save current stats without awk (pure bash)
read -r cpu_line < /proc/stat
echo "$cpu_line" > /tmp/cpu_prev

# --- Audio info ---
sink_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
mic_info=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
volume=$(awk '{printf "%d%%", $2*100}' <<< "$sink_info")
case "$sink_info" in *MUTED*) sink_mute=yes ;; *) sink_mute=no ;; esac
case "$mic_info"  in *MUTED*) mic_mute=yes  ;; *) mic_mute=no  ;; esac
mic_icon=$([ "$mic_mute"  = "yes" ] && echo "🔴" || echo "🟢")
audio_info=$([ "$sink_mute" = "yes" ] && echo "🔇 $volume" || echo "🔉$volume")

# --- Remaining cheap calls ---
gpu_power=$([ "$gpu_power_status" = "low" ] && echo "🌱" || echo "🚀")
date_formatted=$(date "+%a %d %b %Y, %H:%M")
linux_version=$(uname -r | cut -d'-' -f1)
mesa_version=$(pacman -Q mesa 2>/dev/null | awk '{print $2}' | cut -d- -f1 | cut -d: -f2)
kb_layout=$(swaymsg -t get_inputs \
  | sed -nE 's/.*xkb_active_layout_name.*"([^"]+)".*/\1/p' \
  | head -n1 \
  | cut -c1-2 \
  | tr a-z A-Z)

kb_layout="<span background='#2255b2' foreground='white'><b> $kb_layout </b></span>"
network=$(ip route get 1.1.1.1 2>/dev/null | awk '/dev/{for(i=1;i<=NF;i++) if($i=="dev") print $(i+1)}')
network=$([ -n "$network" ] && echo "⇆" || echo "⛔")

echo "| RAM: $ram_usage ZRAM: $swap_usage VRAM: $vram_percent% | CPU: $cpu_load% @ $cpu_temp°C | GPU: $gpu_usage% @ $gpu_temp°C @ $gpu_fan rpm $gpu_power |                                                                                      | 🐧 $linux_version  ⚙️ $mesa_version | $audio_info $mic_icon $network $kb_layout $date_formatted"
