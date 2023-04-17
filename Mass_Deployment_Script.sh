#!/bin/bash
var=0
while [ $var -ne 3 ]; do
  echo "Press 1 for Non-Root Options"
  echo "Press 2 for Root Options"
  echo "Press 3 to exit"
  read -p "Enter your choice: " choice
  
  case $choice in
    1)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/Configs"
WAYLAND_SETUP_DIR="$SCRIPT_DIR/Wayland Setup"
wayland_choice=0
prev_choice=0
while true; do
  echo ""

  case $choice in
    1)
      echo "Press 1 to Deploy Config Files to ~/"
      echo "Press 2 to Deploy a Wayland Desktop"
      echo "Press 3 to exit"

      read -p "Enter your choice: " subchoice
      echo ""
prev_choice=$subchoice
      case $subchoice in
        1)
          cd "$CONFIG_DIR" || exit
          ls

          echo "Enter '[A]ll' to copy all config files, or enter specific filename(s) one at a time, press 'q' to quit at any time:"
       while true; do    
          read files
    
          if [ "$files" == "A" ]; then
            cp -r * ~/.config/
            cp rtorrent.rc ~/.rtorrent.rc 
            cp zshrc ~/.zshrc
            rm ~/.config/rtorrent.rc
            rm ~/.config/zshrc
          elif [ "$files" == "zshrc" ]; then 
            cp zshrc ~/.zshrc
            elif [ "$files" == "rtorrent.rc" ]; then 
            cp rtorrent.rc ~/.rtorrent.rc
            elif [ "$files" == "q" ]; then
            echo "exiting..."
            break
          else
            cp -r "$files" ~/.config
          fi
       done
          echo "Config files copied successfully!"
          ;;
        2)
          echo "Press 1 for Hyprland" 
          echo "Press 2 for Sway"
          echo "3. ↩"
          read -p "Enter your choice: " wayland_choice
          echo ""

          case $wayland_choice in
            1)
              cd "$WAYLAND_SETUP_DIR/Hyprland" || exit
              cp -r * ~/.config/
              echo "Hyprland Desktop deployed successfully!"
              ;;
            2)
              cd "$WAYLAND_SETUP_DIR/Sway" || exit
              cp -r * ~/.config/
              echo "Sway Desktop deployed successfully!"
              ;;
            3)
              wayland_choice=$subchoice
              ;;
            *)
              echo "Invalid choice"
              ;;
          esac
          ;;
          3)
          break
          ;;
        *)
          echo "Invalid choice"
          ;;
      esac
      ;;
    *)
      echo "Invalid choice"
      ;;
  esac
done

;;

2)

# Set the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
choice=0
prev_choice=0
iocache_choice=0
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
          echo "1. I/O&Cache"
          echo "2. MGLRU"
          echo "3. ZRAM"
          echo "4. Exit"
          read -p "Enter your choice: " subchoice
prev_choice=$choice
          case $subchoice in
            1)
              # Ask the user for regular or low RAM scenario
              echo " "
              echo "1. Regular scenario"
              echo "2. Low RAM scenario (Only for =<4GB Ram & combine with Zram)"
              echo "3. ↩"
              read -p "Enter your choice: " iocache_choice
              
              case $iocache_choice in
                1)
                  # Copy files for regular scenario and execute sysctl -p
                  echo "Copying files for regular scenario..."
                  dir="/etc/udev/rules.d"
                  dir2="/etc/sysctl.d/"
                  if [ ! -d "$dir" ]; then
                   sudo mkdir -p "$dir"
                  fi
                  sudo cp "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" /etc/udev/rules.d/60-ioschedulers.rules
                  if [ ! -d "$dir2" ]; then
                   sudo mkdir -p "$dir2"
                  fi
                  sudo cp "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/sysctl.conf" /etc/sysctl.d/99-sysctl.conf
                  sudo sysctl --system
                  ;;
                2)
                  # Copy files for low RAM scenario and execute sysctl -p
                  echo "Copying files for low RAM scenario..."
                  dir="/etc/udev/rules.d"
                  dir2="/etc/sysctl.d/"
                  if [ ! -d "$dir" ]; then
                   sudo mkdir -p "$dir"
                  fi
                  sudo cp "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/60-ioschedulers.rules" /etc/udev/rules.d/60-ioschedulers.rules
                  if [ ! -d "$dir2" ]; then
                   sudo mkdir -p "$dir2"
                  fi
                  sudo cp "$SCRIPT_DIR/Optimizations/IO-Schedulers-Cache-Configs/sysctl_low_ram.conf" /etc/sysctl.d/99-sysctl.conf
                  sudo sysctl --system
                  ;;
                3)
                 iocache_choice=$prev_choice # Set choice to previous menu choice
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
    sudo cp "$SCRIPT_DIR/Optimizations/MGLRU/mglru" /bin/mglru
    sudo chmod +x /bin/mglru
    sudo cp "$SCRIPT_DIR/Optimizations/MGLRU/mglru.service" /lib/systemd/system/mglru.service
    sudo systemctl enable --now mglru.service
    echo "MGLRU installed and enabled"
    ;;
            3)
# Code for ZRAM option
    echo "Installing ZRAM..."
    sudo cp "$SCRIPT_DIR/Optimizations/Zram/zram" /bin/zram
    sudo chmod +x /bin/zram
    sudo cp "$SCRIPT_DIR/Optimizations/Zram/zram.service" /lib/systemd/system/zram.service
    sudo systemctl enable --now zram.service
    echo "ZRAM installed and enabled"
    ;;
           4)
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
  exit
fi

;;
3)
      # Exit the script
      exit
      ;;
*) 
      # Code to execute if the user enters an invalid choice
      echo "Invalid choice, please enter 1 or 2 or 3"
      continue
      ;;
  esac
  
done
