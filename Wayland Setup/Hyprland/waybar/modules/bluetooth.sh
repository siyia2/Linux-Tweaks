#!/bin/sh

upower --dump | grep "percentage" | head -n 1 | tail -c 5

