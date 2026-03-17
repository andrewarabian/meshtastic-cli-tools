#!/bin/bash
# //\ eshtastic CLI Installation Script (Linux) - March 11, 2026 20:17PM PST
# https://github.com/andrewarabian
#
# Install script for the meshtastic python command line interface tool
#
# For systems that use pipx ex. (CentOS) use the pipx counterpart.
#
#
echo -e "\e[32m       _//             _//_//      
      _//             _//  _//     
     _//             _//    _//    
    _//             _//      _//   
   _//             _//        _//  
  _//             _//          _// 
 _//             _//            _//
                                   \e[0m"
pip3 install --upgrade pytap2
echo -e "\e[32m/ /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ \e[0m"
pip3 install --upgrade "meshtastic[cli]"
echo -e "\e[32m/ /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ \e[0m"
echo "Verifying Installation..."
echo -e "\e[32mMeshtastic Version \e[0m" && meshtastic --version

echo -e "\e[32mComplete.\e[0m"
