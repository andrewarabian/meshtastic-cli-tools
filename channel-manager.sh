#!/bin/bash

echo -e "\e[32m==== Meshtastic Channel Manager ====\e[0m"
echo
echo -e "\e[32m       _//             _//_//      
      _//             _//  _//     
     _//             _//    _//    
    _//             _//      _//   
   _//             _//        _//  
  _//             _//          _// 
 _//             _//            _//
                                   \e[0m"

CHANNELS=$(meshtastic --info | grep "Index")

if [ -z "$CHANNELS" ]; then
    echo "[!] No channels found or device not responding."
    exit 1
fi

echo -e "\e[0;35mAvailable Channels : \e[0m"
echo "-------------------"

echo "$CHANNELS" | while read -r line; do
    INDEX=$(echo "$line" | awk '{print $2}' | tr -d ':')
    TYPE=$(echo "$line" | awk '{print $3}')
    
    # Extract name
    NAME=$(echo "$line" | grep -o '"name": *"[^"]*"' | cut -d'"' -f4)

    # Extract PSK
    PSK=$(echo "$line" | grep -o '"psk": *"[^"]*"' | cut -d'"' -f4)

    # Override for default PSK
    if [ "$PSK" == "AQ==" ]; then
        NAME="LongFast (Default)"
    fi

    # Fallback if still empty
    if [ -z "$NAME" ]; then
        NAME="(no name)"
    fi

    echo "[$INDEX] $TYPE - $NAME"
done

echo
read -p "Enter channel index to delete (or 'q' to quit): " INDEX

# Exit condition
if [[ "$INDEX" == "q" ]]; then
    echo "Exiting."
    exit 0
fi

# Validate input
if ! [[ "$INDEX" =~ ^[0-9]+$ ]]; then
    echo -e "\033[31m[INFO] Invalid input. Must be a number.\033[0m"
    exit 1
fi

# Extra safety for PRIMARY (index 0)
if [ "$INDEX" -eq 0 ]; then
    read -p "[INFO] You are about to delete PRIMARY (LongFast). Are you sure? (y/N): " CONFIRM
    if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
        echo "Aborted."
        exit 0
    fi
fi

echo
echo -e "\e[33m[INFO] Deleting channel index ($INDEX)...\e[0m"

meshtastic --ch-del --ch-index "$INDEX"
meshtastic --ch-disable --ch-index "$INDEX"
if [ $? -eq 0 ]; then
    echo -e "\e[32m[SUCCESS] Channel deleted successfully.\e[0m"
else
    echo -e "\033[31m[ERROR] Failed to delete channel.\033[0m"
fi
