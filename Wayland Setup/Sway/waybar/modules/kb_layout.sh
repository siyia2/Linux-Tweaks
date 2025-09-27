#!/bin/bash

get_layout() {
    local layout=$(swaymsg -t get_inputs | grep -A1 '"xkb_active_layout_name"' | grep -o '"[^"]*"' | tail -n1 | tr -d '"')
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
