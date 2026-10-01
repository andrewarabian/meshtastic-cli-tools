#!/bin/bash
# / /\ eshtastic TAK Configuration Script for (Linux) - March 11, 2026 20:17PM PST
# https://github.com/andrewarabian
#
# Streamline TAK use for Meshtastic nodes
#
# Testing indicates that a 10-second interval provides stable TAK GPS positioning on firmware 2.7.26.
# Using values below 2 seconds may cause GPS instability or prevent positioning from working correctly.
#
# If you see any read / write errors during a specific point in the script, run it again or reboot your node.
#
# Please report all bugs or errors on my github page.
#
echo -e "\033[0;34m                                                 ##
                                                ####
                                              ########
                                            ####*+**####
                                          ####*+++****####
                                       #####++++++******####*
                                    #####*+++++++++***+++*#####*
                                **####**++++++++++****+**+******###
                             ##*####+++++++*#*###########**+*+***######
                        ########*++++++++*#################*********########
                ############*++++++++++*####################***********#############
                #######**+*+*+++=+++++*######################*+**************#######
                ###****++++++++++=++++*###################*##********************###
                ###**+++++++++++++++=++*+##################*#********************###
                ###***++*++++++++++++++######################********************###
                ###**+++*++++++++=+++++##++++*###**###****###*******************####
                ####*+*+++++++++++=++**##++**+*+*##*******###*******************####
                 ###*******+++++++++***######################*******************###
                 ###********++*+++++**###########**##########*******************###
                 ###*****+***++++++++******#####*########***********************###
                 ####********++*+*+++******##############**********************####
                  ###*******+++**************##*#*##*##************************###
                  ####*******+*****+*************+****************************####
                   ###********************************************************####
                 ###################################################################
                ####################################################################
               ######################################################################
               ##############-*#######=---------=#######-*########---*###++--=#######
              ##############---###########***##########--=#######*---###=---*#########
              ##############----##########---#########---+=#######---###+--###########
             #############=--#--+#########+++#######*-=#---#######---+--=##############
             ############+--# #---########---#######--# #=--######=+-=-=--#############
            ############=-=#---#+*-#######+++######-=#---#-*-####*---##*---*############
            ###########*---######=-=#####*---#####---######--*###+-- ###=--=*############
           ###########+---*######----#####---####----######*---###*-=*###*---=############
           ###############################################################################
          #################################################################################
          ########################**#######################################################
                                 ####***************************####
                                  ####*************************####
                                    ####*********************####
                                     ####*+****************#####
                                       ####**************#####
                                         #####*********#####
                                           #####****######
                                             ##########
                                                #####
                                                 ###  \033[0m"


check_error() {
    if echo "$1" | grep -qi "couldn't be opened\|no data\|disconnected"; then
        echo -e "\e[31m[ERROR] Temporary failure detected. Please re-run the script.\e[0m"
        exit 1
    fi
}

run() {
    for i in {1..3}; do
        output=$(meshtastic "$@" 2>&1)
        status=$?
        echo "$output"

        if ! echo "$output" | grep -qiE "couldn't be opened|no data|disconnected|OS Error|Input/output error"; then
            if [ "$status" -eq 0 ]; then
                return 0
            fi
            echo -e "\e[31m[ERROR] meshtastic exited with status $status. Configuration not applied.\e[0m"
            exit 1
        fi

        echo -e "\e[33m[SERIAL] Non-fatal Input/output error detected | retrying ($i)...\e[0m"
        sleep 1
    done

    echo -e "\e[31m[ERROR] Persistent failure after retries. Re-run script.\e[0m"
    exit 1
}

read -p "Enter New CALLSIGN ID (LONG) (36 bytes) [press Enter to keep current]: " OWNER_LONG
read -p "Enter New CALLSIGN ID (SHORT) (4 bytes) [press Enter to keep current]: " OWNER_SHORT

echo -e "\e[33m[INFO] Setting device role to [TAK]...\e[0m"
run --set device.role TAK
run --set position.gps_mode ENABLED

run --set lora.modem_preset SHORT_FAST

echo -e "\e[33m[INFO] Setting smart broadcast minimum interval...\e[0m"
run --set position.broadcast_smart_minimum_interval_secs 10

echo -e "\e[33m[INFO] Setting GPS update interval...\e[0m"
run --set position.gps_update_interval 2

echo -e "\e[33m[INFO] Setting broadcast position maximum interval...\e[0m"
run --set position.position_broadcast_secs 60

echo -e "\e[33m[INFO] Setting smart broadcast minimum distance...\e[0m"
run --set position.broadcast_smart_minimum_distance 10

echo -e "\e[33m[INFO] Refreshing node ID...\e[0m"
if [ -n "$OWNER_LONG" ]; then
    run --set-owner "$OWNER_LONG"
    sleep 1
fi

if [ -n "$OWNER_SHORT" ]; then
    run --set-owner-short "$OWNER_SHORT"
    sleep 1
fi

echo -e "\e[32m[SUCCESS] Configuration committed\e[0m"
