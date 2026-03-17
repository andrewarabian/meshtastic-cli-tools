#!/bin/bash
# / /\eshtastic mounting script for (Linux) - March 8, 2026 14:35 PM PST
# https://github.com/andrewarabian
# This simple script mounts your node without hassle, it streamlines the usergroup assignment process.
echo -e "\e[32mAssigning current user to the dialout group...\e[0m"
sudo usermod -a -G dialout $USER
echo -e "\e[32mMounting dialout...\e[0m"
newgrp dialout
echo -e "\e[32mTesting serial connection...\e[0m"
meshtastic --nodes
echo -e "\e[32mComplete\e[0m"
