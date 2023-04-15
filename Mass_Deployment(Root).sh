#!/bin/bash

# Set the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
choice=0
prev_choice=0
# Prompt the user for the root password
echo -n "Enter root password: "
read -s password

# Check if the user pressed escape
if [ -z "$password" ]; then
  exit
fi

# Authenticate the user as root
echo "$password" | sudo -S true 2>/dev/null

if [ $? -eq 0 ]; then
  # The user is authenticated as root

  # Show the root options menu
  while [ $choice -ne 2 ]; do
    echo " "
    echo "To Stop the Script at Any Point press ctrl+c"
    echo "1. Root Options"
    echo "2. Exit"
    read -p "Enter your choice: " choice
      prev_choice=$choice
    case $choice in
      1)
        # Show the Root Options menu
        while [ $choice -ne 4 ]; do
          echo "1. I/O&Cache"
          echo "2. MGLRU"
          echo "3. ZRAM"
          echo "4. ↩"
          read -p "Enter your choice: " subchoice
       prev_choice=$choice
          case $subchoice in
            1)
              # Ask the user for regular or low RAM scenario
              echo " "
              echo "1. Regular scenario"
              echo "2. Low RAM scenario (Only for <4GB Ram & combine with Zram)"
              echo "3. ↩"
              read -p "Enter your choice: " iocache_choice
        iocache_choice=$choice
              case $iocache_choice in
                1)
                  # Copy files for regular scenario and execute sysctl -p
                  echo "Copying files for regular scenario..."
                  sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" /etc/udev/rules.d/60-ioschedulers.rules
                  sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/sysctl.conf" /etc/sysctl.d/99-sysctl.conf
                  sudo sysctl --system
                  ;;
                2)
                  # Copy files for low RAM scenario and execute sysctl -p
                  echo "Copying files for low RAM scenario..."
                  sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" /etc/udev/rules.d/60-ioschedulers.rules
                  sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/sysctl_low_ram.conf" /etc/sysctl.d/99-sysctl.conf
                  sudo sysctl --system
                  ;;
                3)
              break  # Set choice to previous menu choice
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
    sudo cp "$SCRIPT_DIR/MGLRU/mglru" /bin/mglru
    sudo chmod +x /bin/mglru
    sudo cp "$SCRIPT_DIR/MGLRU/mglru.service" /lib/systemd/system/mglru.service
    sudo systemctl enable --now mglru.service
    echo "MGLRU installed and enabled"
    ;;
            3)
# Code for ZRAM option
    echo "Installing ZRAM..."
    sudo cp "$SCRIPT_DIR/Zram/zram" /bin/zram
    sudo chmod +x /bin/zram
    sudo cp "$SCRIPT_DIR/Zram/zram.service" /lib/systemd/system/zram.service
    sudo systemctl enable --now zram.service
    echo "ZRAM installed and enabled"
    ;;
        4)
              break  # Set choice to previous menu choice
              ;;
            *)
              # Invalid subchoice
              echo "Invalid choice"
              ;;
          esac
        done
        ;;
      2)
        # Exit the script
        exit
        ;;
      *)
        # Invalid choice
        echo "Invalid choice"
        ;;
    esac
  done
else
  # The user entered an incorrect password
  echo "Incorrect password"
  exit
fi
