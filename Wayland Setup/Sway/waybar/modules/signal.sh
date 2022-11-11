#!/bin/bash

signal=$(iwconfig wlan0|awk '/Link Quality/{split($2,a,"=|/");print int((a[2]/a[3])*100)}')
echo "$signal"


exit
