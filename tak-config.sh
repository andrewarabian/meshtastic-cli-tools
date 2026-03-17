#!/bin/bash
# / /\ eshtastic TAK Configuration Script for (Linux) - March 11, 2026 20:17PM PST
# https://github.com/andrewarabian
#
# Streamline TAK use for Meshtastic nodes
#
# Testing indicates that a 2-second interval provides stable TAK GPS positioning on firmware 2.7.15.
# Using values below 2 seconds may cause GPS instability or prevent positioning from working correctly.
#
# If you see any issues during a specific point in the script, run it again or reboot your node.
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
              ##############----##########---##########--+=#######---###+--###########
             #############=--#--+#########+++#######*-=#---#######---+--=##############             
             ############+--# #---########---#######--# #=--######=+-=-=--#############             
            ############=-=#---#+*-#######+++######-=#---#-*-####*---##*---*############            
            ###########*---######=-=#####*---#####---######--*###+--###=--=*#############          
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

echo -e "\e[32mMeshtastic TAK Configuration Script for (Linux)\e[0m"

read -p "Enter New ID (LONG) (36 bytes) [press Enter to keep current]: " OWNER_LONG
read -p "Enter New ID (SHORT) (4 bytes) [press Enter to keep current]: " OWNER_SHORT

echo -e "\e[32mSetting device role to TAK\e[0m"
meshtastic --set device.role TAK
sleep 2

echo -e "\e[32mUpdating smart broadcast minimum interval...\e[0m"
meshtastic --set position.broadcast_smart_minimum_interval_secs 2	
sleep 2

echo -e "\e[32mUpdating GPS update interval...\e[0m"
meshtastic --set position.gps_update_interval 2
sleep 2

echo -e "\e[32mUpdating broadcast position maximum interval...\e[0m"
meshtastic --set position.position_broadcast_secs 2	
sleep 2

echo -e "\e[32mUpdating smart broadcast minimum distance...\e[0m"
meshtastic --set position.broadcast_smart_minimum_distance 2
sleep 2

echo -e "\e[32mApplying node identity settings...\e[0m"

if [ -n "$OWNER_LONG" ]; then
    meshtastic --set-owner "$OWNER_LONG"
    sleep 2
fi

if [ -n "$OWNER_SHORT" ]; then
    meshtastic --set-owner-short "$OWNER_SHORT"
    sleep 2
fi

echo -e "\e[1;35mConfiguration Committed\e[0m"


