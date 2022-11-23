#!/bin/bash
volume=$(pactl get-source-volume @DEFAULT_SOURCE@ | head -n 1 | tail -c 16 | cut -c 1,2)
high="45"
low="05"

if [[ "$volume" == *"5"* ]]

then

pactl set-source-volume @DEFAULT_SOURCE@ 45% ;

fi

if [[ "$volume" == *"45"* ]]
then

pactl set-source-volume @DEFAULT_SOURCE@ 5% ;


fi

exit
