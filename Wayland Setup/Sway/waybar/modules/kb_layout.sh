#!/bin/bash

get_layout() {
    swaymsg -t get_inputs | awk '/xkb_active_layout_name/{print $2}' | sed 's/^"//;s/"$//'
}

layout=""
while true; do
    new_layout=$(get_layout)
    if [ "$new_layout" != "$layout" ]; then
        layout=$new_layout
        echo "$layout"
    fi
    sleep 1
done
