#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/Configs"
WAYLAND_SETUP_DIR="$SCRIPT_DIR/Wayland Setup"

while true; do
  echo "To Stop the Script at Any Point press ctrl+c"
  echo "Press 1 for Non-Root Options"
  echo "Press 2 to Exit"

  read -p "Enter your choice: " choice
  echo ""

  case $choice in
    1)
      echo "Press 1 to Deploy Config Files to ~/"
      echo "Press 2 to Deploy a Wayland Desktop"

      read -p "Enter your choice: " subchoice
      echo ""

      case $subchoice in
        1)
          cd "$CONFIG_DIR"
          ls

          echo "Enter '[A]ll' to copy all files or directories, or enter the file or directory names separated by a space:"
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
          else
            cp -r $files ~/.config
          fi

          echo "Config files copied successfully!"
          ;;
        2)
          echo "Press 1 for Hyprland or Press 2 for Sway:"
          read -p "Enter your choice: " subchoice
          echo ""

          case $wayland_choice in
            1)
              cd "$WAYLAND_SETUP_DIR/Hyprland"
              cp -r * ~/.config/
              echo "Hyprland Desktop deployed successfully!"
              ;;
            2)
              cd "$WAYLAND_SETUP_DIR/Sway"
              cp -r * ~/.config/
              echo "Sway Desktop deployed successfully!"
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
      ;;
    2)
      echo "Exiting..."
      exit 0
      ;;
    $'\e')
      echo "Returning to previous menu..."
      continue
      ;;
    *)
      echo "Invalid choice"
      ;;
  esac
done
