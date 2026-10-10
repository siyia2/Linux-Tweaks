#!/usr/bin/env bash

bluetoothctl info 40:72:18:2B:75:18 | grep "Battery Percentage" | awk -F '[()]' '{print $2}'
