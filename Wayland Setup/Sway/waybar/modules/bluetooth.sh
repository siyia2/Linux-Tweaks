#!/bin/sh

bluetoothctl info | grep "Battery Percentage:" | awk '{print $4}' | tr -d '()' | awk '{print $1"%"}'
