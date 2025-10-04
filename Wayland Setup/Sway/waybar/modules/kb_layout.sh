#!/bin/bash

get_layout() {
    local layout=$(swaymsg -t get_inputs | grep 'xkb_active_layout_name' | head -n1 | sed 's/.*: "\([^"]*\)".*/\1/' | cut -c1-2)
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
