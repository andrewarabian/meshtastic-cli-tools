#!/bin/bash
# / /\eshtastic dialout setup script - March 8, 2026 14:35 PM PST
# https://github.com/andrewarabian
# This simple script mounts your node without hassle, it streamlines the usergroup assignment process.
if [ "$(uname -s)" != "Linux" ]; then
    echo -e "\e[31m[ERROR] This script is Linux only. macOS needs no serial group.\e[0m"
    exit 1
fi

USER_NAME="$(id -un)"

# Arch and openSUSE put serial devices in uucp, everyone else uses dialout
SERIAL_GROUP="dialout"
if command -v pacman >/dev/null 2>&1 || command -v zypper >/dev/null 2>&1; then
    SERIAL_GROUP="uucp"
fi

if ! getent group "$SERIAL_GROUP" >/dev/null 2>&1; then
    echo -e "\e[31m[ERROR] There is no $SERIAL_GROUP group on this system.\e[0m"
    exit 1
fi

echo -e "\e[32mAssigning current user to the $SERIAL_GROUP group...\e[0m"
if ! sudo usermod -a -G "$SERIAL_GROUP" "$USER_NAME"; then
    echo -e "\e[31m[ERROR] Could not add $USER_NAME to $SERIAL_GROUP.\e[0m"
    exit 1
fi

echo -e "\e[32mTesting serial connection...\e[0m"
if ls /dev/ttyUSB* >/dev/null 2>&1 || ls /dev/ttyACM* >/dev/null 2>&1; then
    sg "$SERIAL_GROUP" -c "meshtastic --nodes"
else
    echo -e "\e[33m[WARN] No serial device found. Plug in the radio and re-run.\e[0m"
fi

echo -e "\e[32mComplete\e[0m"
echo -e "\e[32mMounting $SERIAL_GROUP...\e[0m"
exec newgrp "$SERIAL_GROUP"
