#!/bin/bash
# / /\ eshtastic CLIENT_HIDDEN Configuration Script for (Linux) - March 15, 2026 20:17PM PST
# https://github.com/andrewarabian
#
# This script by default disables all GPS positioning, and smart position broadcasting.
#
# The CLIENT_HIDDEN device role is for stealth/hidden deployments or to reduce airtime/power consumption while still participating in the network.
#
# CLIENT_HIDDEN Meshtastic is designed to keep your node hidden from the node list on other users' devices.
#
# Although this mode hides you from the node list on other users, you can still pick up new nodes as well as engage in the mesh network.
# This script/role does not remove, or erase you from other nodes raw history from a previous (CLIENT) session.
#
# If you see any issues during a specific point in the script, run it again or reboot your node.
# 
# Please report all bugs or errors on my github page.
#
echo -e "\e[32m       _//             _//_//      
      _//             _//  _//     
     _//             _//    _//    
    _//             _//      _//   
   _//             _//        _//  
  _//             _//          _// 
 _//             _//            _//
                                   \e[0m"
echo -e "\e[32mSetting device role to CLIENT_HIDDEN\e[0m"
meshtastic --set device.role CLIENT_HIDDEN
echo -e "\e[32mDisabling smart broadcasts...\e[0m"
sleep 1
meshtastic --set position.position_broadcast_smart_enabled false
echo -e "\e[32mDisabling GPS positioning\e[0m"
sleep 1
meshtastic --set position.gps_mode DISABLED
echo -e "\e[32mSetting rebroadcast mode to ALL...\e[0m"
sleep 1
meshtastic --set device.rebroadcast_mode ALL
echo -e "\e[32mNode ID configuration\e[0m"
sleep 1
read -p "Enter New ID (LONG) (36 bytes) [press Enter to keep current]: " OWNER_LONG
if [ -n "$OWNER_LONG" ]; then
    meshtastic --set-owner "$OWNER_LONG"
fi

read -p "Enter New ID (SHORT) (4 bytes) [press Enter to keep current]: " OWNER_SHORT
if [ -n "$OWNER_SHORT" ]; then
    meshtastic --set-owner-short "$OWNER_SHORT"
fi
sleep 3
echo -e "\e[1;35mConfiguration Committed\e[0m"

