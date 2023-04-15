#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/Configs"
WAYLAND_SETUP_DIR="$SCRIPT_DIR/Wayland Setup"

while true; do
  echo "Press 1 for Non-Root Options"
  echo "Press 2 to Exit"

  read -n1 choice
  echo ""

  case $choice in
    1)
      echo "Press 1 to Deploy Config Files to ~/"
      echo "Press 2 to Deploy a Wayland Desktop"

      read -n1 subchoice
      echo ""

      case $subchoice in
        1)
          cd "$CONFIG_DIR"
          ls

          echo "Enter '[A]ll' to copy all files or directories, or enter the file or directory names separated by a space:"
          read files

          if [ "$files" == "A" ]; then
            cp -r * ~/Downloads/config/
            cp rtorrent.rc ~/Downloads/.rtorrent.rc 
            cp zshrc ~/Downloads/.zshrc
            rm ~/Downloads/config/rtorrent.rc
            rm ~/Downloads/config/zshrc
            rm ~/Downloads/config/.Instructions
          elif [ "$files" == "zshrc" ]; then 
            cp zshrc ~/Downloads/.zshrc
            elif [ "$files" == "rtorrent.rc" ]; then 
            cp rtorrent.rc ~/Downloads/.rtorrent.rc
          else
            cp -r $files ~/Downloads/config
          fi

          echo "Config files copied successfully!"
          ;;
        2)
          echo "Press 1 for Hyprland or Press 2 for Sway:"
          read -n1 wayland_choice
          echo ""

          case $wayland_choice in
            1)
              cd "$WAYLAND_SETUP_DIR/Hyprland"
              cp -r * ~/Downloads/config/
              echo "Hyprland Desktop deployed successfully!"
              ;;
            2)
              cd "$WAYLAND_SETUP_DIR/Sway"
              cp -r * ~/Downloads/config/
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
