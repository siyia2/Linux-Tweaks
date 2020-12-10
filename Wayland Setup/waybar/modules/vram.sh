#!/bin/bash
gpu_vram_mb=$(cat /sys/class/drm/card0/device/mem_info_vram_used | grep -Po '.*(?=......$)')
vram_total=4096
vram_percent=$(awk "BEGIN { pc=100*${gpu_vram_mb}/${vram_total}; i=int(pc); print (pc-i<0.5)?i:i+1 }")
echo $vram_percent
exit
