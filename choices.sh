#!/bin/bash

cd "$(dirname "$0")"

PS4='Please enter your choice: '
options=("Zram" "Configs" "MGLRU" "Wayland" "FS_scripts" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Zram")

            ;;
        "Configs")
           cp -ri configs/.  ~/
            ;;
        "MGLRU")
           sudo cp -r configs/s1 /s1
            ;;
        "Wayland")
            echo "you chose choice $REPLY which is $opt"
            ;;
            "FS_Scripts")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
