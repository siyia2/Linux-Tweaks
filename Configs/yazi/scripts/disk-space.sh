#!/bin/bash

# Check if running with root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Warning: Not running as root. Some devices might not be visible."
fi

# Function to convert bytes to human-readable format
convert_size() {
    local size=$1
    local units=("B" "KB" "MB" "GB" "TB")
    local unit=0

    # Remove decimal points and trailing zeros for comparison
    size_int=$(echo "$size" | cut -d. -f1)
    
    # Convert using bc for floating point arithmetic
    while [ $unit -lt ${#units[@]} ]; do
        if [ $size_int -lt 1024 ]; then
            break
        fi
        size=$(echo "scale=2; $size/1024" | bc)
        size_int=$(echo "scale=0; $size_int/1024" | bc)
        unit=$((unit + 1))
    done

    printf "%.2f%s" $size "${units[$unit]}"
}

# Print header
printf "\n%-20s %-12s %-12s %-12s %-8s %-20s\n" "Device" "Total" "Used" "Free" "Use%" "Mount Point"
echo "--------------------------------------------------------------------------------"

# Get disk information using df directly
df -P | grep "^/dev" | while read -r dfline; do
    device=$(echo "$dfline" | awk '{print $1}')
    device_name=$(basename "$device")
    total=$(echo "$dfline" | awk '{print $2 * 1024}')
    used=$(echo "$dfline" | awk '{print $3 * 1024}')
    free=$(echo "$dfline" | awk '{print $4 * 1024}')
    usage=$(echo "$dfline" | awk '{print $5}')
    mount=$(echo "$dfline" | awk '{print $6}')
    
    # Convert values to human-readable format
    total_h=$(convert_size $total)
    used_h=$(convert_size $used)
    free_h=$(convert_size $free)
    
    printf "%-20s %-12s %-12s %-12s %-8s %-20s\n" "$device_name" "$total_h" "$used_h" "$free_h" "$usage" "$mount"
done

echo -e "\nNote: Only mounted block devices are shown."
/bin/bash
