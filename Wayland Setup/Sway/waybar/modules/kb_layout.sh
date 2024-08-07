#!/bin/bash

get_layout() {
    local layout=$(swaymsg -t get_inputs | grep -o -E '"xkb_active_layout_name".*' | sed 's/"xkb_active_layout_name": "\(.*\)"/\1/')
    echo "$layout"
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
