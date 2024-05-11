#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

clear
# Function to print the menu
print_menu() {
    echo -e "${CYAN}╔════════════════════════════╗${NC}"
    echo -e "${CYAN}║${PURPLE}        Main Menu           ${CYAN}║${NC}"
    echo -e "${CYAN}╠════════════════════════════╣${NC}"
    echo -e "${CYAN}║${GREEN} 1 Non-Root Options         ${CYAN}║${NC}"
    echo -e "${CYAN}║${GREEN} 2 Root Options            ${CYAN} ║${NC}"
    echo -e "${CYAN}║${RED} 3 Exit                    ${CYAN} ║${NC}"
    echo -e "${CYAN}╚════════════════════════════╝${NC}"
}

# Function to print non-root options menu
print_non_root_options() {
    echo -e "${CYAN}╔═══════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${PURPLE}      Non-Root Options             ${CYAN}║${NC}"
    echo -e "${CYAN}╠═══════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${GREEN} 1 Deploy Config Files into ~/     ${CYAN}║${NC}"
    echo -e "${CYAN}║${GREEN} 2 Deploy a Wayland Desktop        ${CYAN}║${NC}"
    echo -e "${CYAN}╚═══════════════════════════════════╝${NC}"
}

# Function to print Wayland options menu
print_wayland_options() {
    echo -e "${CYAN}╔══════════════════════════════╗${NC}"
    echo -e "${CYAN}║${PURPLE}      Wayland Options         ${CYAN}║${NC}"
    echo -e "${CYAN}╠══════════════════════════════╣${NC}"
    echo -e "${CYAN}║${GREEN} 1 Hyprland                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${GREEN} 2 Sway                       ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════╝${NC}"
}

# Function to print root options menu
print_root_options() {
    echo -e "${CYAN}╔══════════════════════════════╗${NC}"
    echo -e "${CYAN}║${PURPLE}        Root Options          ${CYAN}║${NC}"
    echo -e "${CYAN}╠══════════════════════════════╣${NC}"
    echo -e "${CYAN}║${GREEN} 1. I/O & Cache               ${CYAN}║${NC}"
    echo -e "${CYAN}║${GREEN} 2. MGLRU                     ${CYAN}║${NC}"
    echo -e "${CYAN}║${GREEN} 3. ZRAM                      ${CYAN}║${NC}"
    echo -e "${CYAN}║${RED} 4. Exit                      ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════╝${NC}"
}

# Function to handle non-root options
non_root_options() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    CONFIG_DIR="$SCRIPT_DIR/Configs"
    WAYLAND_SETUP_DIR="$SCRIPT_DIR/Wayland Setup"

    while true; do
    clear
        print_non_root_options
        read -rp "Enter your choice or press ENTER to return: " subchoice
        echo -e ""

        case "$subchoice" in
            1)
                cd "$CONFIG_DIR" || exit
                    ls --color=always | sed "s/\(^.*\)/$(printf '%b' '\033[0;95m')\1$(printf '%b' '\033[0m')/"
                    
                    echo -e "\nEnter 'A' to deploy all config files, or enter specific filename(s) separated by space, press 'q' or ENTER to quit:"
                    while true; do
                        read -erp $'\n'"Files(Tab completion is available): " files
                    
                        if [ "$files" = "q" ] || [ -z "$files" ]; then
                            break
                        elif [ "$files" = "A" ]; then
                            cp -r * ~/.config/
                            cp rtorrent.rc ~/.rtorrent.rc
                            cp zshrc ~/.zshrc
                            rm ~/.config/rtorrent.rc ~/.config/zshrc
                            echo "Config files deployed successfully!"
                        else
                           # Autocompletion
							IFS=' ' read -r -a file_array <<< "${files//\/}"
    						for file in "${file_array[@]}"; do
        						if [ "$file" = "zshrc" ]; then
           							 cp zshrc ~/.zshrc
        						elif [ "$file" = "rtorrent.rc" ]; then
            						cp rtorrent.rc ~/.rtorrent.rc
        				else
            				cp -r "$file" ~/.config
        				fi
    					done
    					echo "Config files deployed successfully!"
						fi
                    done
                    ;;
            2)
                while true; do
                clear
                print_wayland_options
                    read -rp "Enter your choice or press ENTER to return: " wayland_choice

                    case "$wayland_choice" in
                        1)
                            cd "$WAYLAND_SETUP_DIR/Hyprland" || exit
                            cp -r * ~/.config/
                            echo -n "Hyprland Desktop deployed successfully!"
                            read -n 1 -s
                            ;;
                        2)
                            cd "$WAYLAND_SETUP_DIR/Sway" || exit
                            cp -r * ~/.config/
                            echo -n "Sway Desktop deployed successfully!"
                            read -n 1 -s
                            ;;

                        3|"")
                            break
                            ;;

                        *)
                            echo "Invalid choice"
                            ;;
                    esac
                done
                ;;

             3|"")
                break
                ;;
            *)
                echo "Invalid choice"
                ;;
        esac
    done
}

# Function to handle root options
root_options() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Prompt the user for the root password
    echo -n "Enter root password: "
    read -rs password

    # Check if the user pressed escape
    if [ -z "$password" ]; then
        exit
    fi

    # Authenticate the user as root
    echo "$password" | sudo -S true 2>/dev/null

    if [ $? -eq 0 ]; then
        # The user is authenticated as root

        # Show the root options menu
        while true; do
        clear
            print_root_options
            read -rp "Enter your choice: " subchoice

            case "$subchoice" in
                1)
                    # Ask the user for regular or low RAM scenario
                    echo " "
                    echo "1. Regular scenario"
                    echo "2. Low RAM scenario (Only for =<4GB Ram & combine with Zram)"
                    echo "3. Go back"
                    read -rp "Enter your choice: " iocache_choice

                    case "$iocache_choice" in
                        1)
                            # Copy files for regular scenario and execute sysctl -p
                            echo "Copying files for regular scenario..."
                            dir="/etc/udev/rules.d"
                            dir2="/etc/sysctl.d/"
                            mkdir -p "$dir" "$dir2"
                            sudo cp -f "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" "$dir/60-ioschedulers.rules"
                            sudo cp -f "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/sysctl.conf" "$dir2/99-sysctl.conf"
                            sudo sysctl --system
                            ;;
                        2)
                            # Copy files for low RAM scenario and execute sysctl -p
                            echo "Copying files for low RAM scenario..."
                            dir="/etc/udev/rules.d"
                            dir2="/etc/sysctl.d/"
                            mkdir -p "$dir" "$dir2"
                            sudo cp -f "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" "$dir/60-ioschedulers.rules"
                            sudo cp -f "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/sysctl_low_ram.conf" "$dir2/99-sysctl.conf"
                            sudo sysctl --system
                            ;;

                         3|"")
                            break
                            ;;
                        *)
                            # Invalid iocache_choice
                            echo "Invalid choice"
                            ;;
                    esac
                    ;;
                2)
                    # Code for MGLRU option
                    echo "Installing MGLRU..."
                    sudo cp -f "$SCRIPT_DIR/Optimizations/MGLRU/mglru" /bin/mglru
                    sudo chmod +x /bin/mglru
                    sudo cp -f "$SCRIPT_DIR/Optimizations/MGLRU/mglru.service" /lib/systemd/system/mglru.service
                    sudo systemctl enable --now mglru.service
                    echo -n "MGLRU installed and enabled"
                    read -n 1 -s
                    ;;
                3)
                    # Code for ZRAM option
                    echo "Installing ZRAM..."
                    sudo cp -f "$SCRIPT_DIR/Optimizations/Zram/zram" /bin/zram
                    sudo chmod +x /bin/zram
                    sudo cp -f "$SCRIPT_DIR/Optimizations/Zram/zram.service" /lib/systemd/system/zram.service
                    sudo systemctl enable --now zram.service
                    echo -n "ZRAM installed and enabled"
                    read -n 1 -s
                    ;;

                 4|"")
                    break
                    ;;
                *)
                    # Invalid subchoice
                    echo "Invalid choice"
                    ;;
            esac
        done
    else
        # The user entered an incorrect password
        echo "Incorrect password"
    fi
}

# Main loop
while true; do
clear
    print_menu
    read -rp "Enter your choice: " choice

    case "$choice" in
        1)
            non_root_options
            ;;
        2)
            root_options
            ;;
        3)
            # Exit the script
            exit
            ;;
        *)
            # Code to execute if the user enters an invalid choice
            echo "Invalid choice, please enter 1, 2, or 3"
            ;;
    esac
done
