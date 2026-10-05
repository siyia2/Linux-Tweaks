#!/usr/bin/env bash

upower --dump | awk '
BEGIN { min_time = -1; cur_time = -1; cur_pct = ""; best_pct = "" }

# Reset or process when a new Device block starts
/^Device:/ {
    if (cur_time != -1 && cur_pct != "") {
        if (min_time == -1 || cur_time < min_time) {
            min_time = cur_time
            best_pct = cur_pct
        }
    }
    cur_time = -1
    cur_pct = ""
}

# Capture the seconds ago timestamp
/updated:/ {
    n = split($0, arr, "(")
    if (n > 1) {
        sub(/ seconds ago\).*/, "", arr[2])
        cur_time = arr[2] + 0
    }
}

# Capture the battery percentage
/percentage:/ {
    cur_pct = $2
}

# Process the final device block at the end of the stream
END {
    if (cur_time != -1 && cur_pct != "") {
        if (min_time == -1 || cur_time < min_time) {
            min_time = cur_time
            best_pct = cur_pct
        }
    }
    if (best_pct != "") print best_pct
}
'
