#!/bin/bash

# Set the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
  while true; do
    echo " "
    echo "1. Root Options"
    echo "2. Exit"
    read -p "Enter your choice: " choice

    case $choice in
      1)
        # Show the Root Options menu
        while true; do
          echo "1. I/O&Cache"
          echo "2. MGLRU"
          echo "3. ZRAM"
          read -p "Enter your choice: " subchoice

          case $subchoice in
            1)
              # Ask the user for regular or low RAM scenario
              echo " "
              echo "1. Regular scenario"
              echo "2. Low RAM scenario (Combine with Zram)"
              read -p "Enter your choice: " iocache_choice

              case $iocache_choice in
                1)
                  # Copy files for regular scenario and execute sysctl -p
                  echo "Copying files for regular scenario..."
                 sudo mkdir -p ~/etc/udev/rules.d/ && sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" ~/etc/udev/rules.d/60-ioschedulers.rules
                  sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/sysctl.conf" ~/etc/sysctl.d/99-sysctl.conf
                  sudo sysctl --system
                  ;;
                2)
                  # Copy files for low RAM scenario and execute sysctl -p
                  echo "Copying files for low RAM scenario..."
                  sudo mkdir -p /etc/udev/rules.d/ && sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" /etc/udev/rules.d/60-ioschedulers.rules
                  sudo cp "$SCRIPT_DIR/IO-Schedulers-Cache-Configs/sysctl_low_ram.conf" /etc/sysctl.d/99-sysctl.conf
                  sudo sysctl --system
                  ;;
                *)
                  # Invalid iocache_choice
                  echo "Invalid choice"
                  ;;
              esac
              ;;
            2)
              # Run MGLRU command
              echo "Running MGLRU command"
              ;;
            3)
              # Run ZRAM command
              echo "Running ZRAM command"
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

