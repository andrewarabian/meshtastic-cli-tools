#!/bin/bash
# / /\ eshtastic Bluetooth PIN Configuration Script (Linux) - March 15, 2026 20:17PM PST
# https://github.com/andrewarabian
#
echo -e "\e[32m       _//             _//_//
      _//             _//  _//
     _//             _//    _//
    _//             _//      _//
   _//             _//        _//
  _//             _//          _//
 _//             _//            _//
                                   \e[0m"


read -p "Enter a 6-digit Bluetooth PIN: " PIN

if [[ ! "$PIN" =~ ^[0-9]{6}$ ]]; then
echo -e "\e[31m[ERROR] Invalid input — PIN must be exactly 6 digits\e[0m"

exit 1
fi

echo -e "\e[33m[INFO] Setting Bluetooth fixed PIN..\e[0m"

for i in 1 2 3; do
    output=$(meshtastic --set bluetooth.mode FIXED_PIN --set bluetooth.fixed_pin "$PIN" 2>&1)
    status=$?
    echo "$output"

    if ! echo "$output" | grep -qiE "couldn't be opened|no data|disconnected|OS Error|Input/output error"; then
        if [ "$status" -eq 0 ]; then
            echo -e "\e[32m[SUCCESS] PIN changes committed.\e[0m"
            exit 0
        fi
        echo -e "\e[31m[ERROR] meshtastic exited with status $status. PIN not committed.\e[0m"
        exit 1
    fi

    echo -e "\e[33m[SERIAL] Non-fatal Input/output error detected | retrying... ($i)\e[0m"
    sleep 1
done

echo -e "\e[31m[ERROR] Persistent failure after retries. Re-run script.\e[0m"
exit 1
