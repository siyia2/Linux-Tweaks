#!/bin/sh

upower --dump | grep "percentage" | head -n 1 | awk '{print $NF}'
