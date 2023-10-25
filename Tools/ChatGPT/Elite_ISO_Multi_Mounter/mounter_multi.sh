#!/bin/bash

# Main script
iso_count=1
iso_paths=()

# Function to mount an ISO file
mount_iso() {
    local iso_files=("$@")
    for iso_file in "${iso_files[@]}"; do
        local mount_point="/mnt/iso_$iso_count"
        if [ -e "$mount_point" ]; then
            echo "An ISO is already mounted at '$mount_point'."
        else
            sudo mkdir -p "$mount_point"
            sudo mount -o loop "$iso_file" "$mount_point"
            echo "ISO file '$iso_file' mounted at '$mount_point'."
            mounted_isos+=("$mount_point")  # Add the mount point to the list
            ((iso_count++))
        fi
    done
}

# Function to unmount a specific ISO or multiple ISOs
unmount_iso() {
    local unmount_selection="$1"

    if [[ "$unmount_selection" =~ ^[0-9]+(-[0-9]+)?$ ]]; then
        IFS='-' read -a iso_numbers <<< "$unmount_selection"
        for num in ${iso_numbers[@]}; do
            if [ "$num" -ge 1 ] && [ "$num" -le $iso_count ]; then
                local mount_point="/mnt/iso_$num"
                if [ -e "$mount_point" ]; then
                    sudo umount "$mount_point"
                    sudo rmdir "$mount_point"
                    echo "ISO $num unmounted."
                    # Remove the unmounted ISO from the list
                    mounted_isos=("${mounted_isos[@]/$mount_point}")
                    iso_count=$((iso_count - 1))  # Decrement iso_count
                else {
                    echo "No ISO mounted at '$mount_point'."
                }
                fi
            else {
                echo "Invalid ISO number '$num'. No action performed."
            }
            fi
        done
    else
        local mount_point="/mnt/iso_$unmount_selection"
        if [ -e "$mount_point" ]; then
            sudo umount "$mount_point"
            sudo rmdir "$mount_point"
            echo "ISO $unmount_selection unmounted."
            # Remove the unmounted ISO from the list
            mounted_isos=("${mounted_isos[@]/$mount_point}")
            iso_count=$((iso_count - 1))  # Decrement iso_count
        else {
            echo "No ISO mounted at '$mount_point'."
        }
        fi
    fi
}

# Function to unmount all ISOs
unmount_all_isos() {
    local iso_count="$1"

    for ((i = 1; i < iso_count; i++)); do
        local mount_point="/mnt/iso_$i"
        if [ -e "$mount_point" ]; then
            sudo umount "$mount_point"
            sudo rmdir "$mount_point"
            # Remove the unmounted ISO from the list
            mounted_isos=("${mounted_isos[@]/$mount_point}")
        fi
    done

    echo "All mounted ISOs have been unmounted."
}

# Array to store the list of mounted ISOs
mounted_isos=()

# Main script
iso_count=1
iso_paths=()

while true; do

print_ascii_frame() {
    echo " "
    echo -e "\e[1;32m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓"
    
    echo -e "              ELITE ISO MULTI MOUNTER/CONVERTER                       "
    
    echo -e "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\e[0m"
}

print_ascii_frame  # Print the ASCII frame

    echo "1. Mount an ISO or multiple ISOs (separate paths with spaces)"
    echo "2. Unmount an ISO or multiple ISOs (e.g., '1' or '1-2')"
    echo "3. Unmount all ISOs"
    echo "4. Open /mnt/"
    echo "5. Convert to ISO"
    echo "6. Exit"
    read -p "Choose an option (1/2/3/4): " choice

    case $choice in
        1)
            read -e -p "Enter the paths to the ISO files (separated by spaces): " -a iso_paths
            for iso_path in "${iso_paths[@]}"; do
                if [ -e "$iso_path" ]; then
                    mount_iso "$iso_path"
                else {
                    echo -e "\e[1;31mThe specified ISO file(s) '$iso_path' does not exist, no ISO mounted...\e[0m"
                }
                fi
            done
            ;;
        2)
            if [ $iso_count -eq 1 ]; then {
                echo -e "\e[1;31mNo ISOs are mounted.\e[0m"
            }
            else {
                if [ "${#mounted_isos[@]}" -gt 0 ]; then {
                    echo "List of mounted ISOs:"
                    for ((i = 0; i < "${#mounted_isos[@]}"; i++)); do {
                        echo "ISO $((i+1)): ${mounted_isos[i]}"
                    }
                    done
                }
                else {
                    echo -e "\e[1;31mNo ISOs are mounted.\e[0m"
                }
                fi

                read -p "Enter the number(s) of the ISO(s) to unmount (e.g., '1' or '1-2') or 'exit' to go back: " unmount_selection
                if [ "$unmount_selection" == "exit" ]; then {
                    continue
                }
                else {
                    unmount_iso "$unmount_selection"
                }
                fi
            }
            fi
            ;;
        3)
            if [ $iso_count -eq 1 ]; then {
                echo -e "\e[1;33mNo ISOs are mounted, but cleaning mount dirs just in case...\e[0m"
                sudo umount /mnt/iso_*
                sudo rm -r /mnt/iso_*
            }
            else {
                unmount_all_isos "$iso_count"
                iso_count=1
                mounted_isos=()
            }
            fi
            ;;
        4)
            nohup xdg-open /mnt/ > /dev/null 2>&1&
            read -p "Press Enter to return to the main menu..."
            ;;
        5)
    read -e -p "Enter the path to the image file you want to convert: " input_path
    if [ -e "$input_path" ]; then
        if [[ "$input_path" == *.iso ]]; then
            echo "The file is already in ISO format."
        else
            if command -v ccd2iso &>/dev/null; then
                output_path="${input_path%.*}.iso"
                ccd2iso "$input_path" "$output_path"
                if [ -e "$output_path" ]; then
                    echo "Image file converted to ISO: $output_path"
                else
                    echo "Conversion failed."
                fi
            else
                echo "ccd2iso is not installed. Please install it before using this option."
            fi
        fi
    else
        echo "The specified input file '$input_path' does not exist."
    fi
    read -p "Press Enter to return to the main menu..."
    ;;
        
        6)
            echo "Exiting the program."
            exit 0
            ;;
        
        *)
            echo -e "\e[1;31mInvalid choice. Please enter 1, 2, 3, 4, 5 or 6.\e[0m"
            ;;
    esac
done

