#!/bin/bash
# //\ eshtastic CLI Installation Script (Linux) - March 11, 2026 20:17PM PST
# https://github.com/andrewarabian
#
# Install script for the meshtastic python command line interface tool
#
# For systems that use pip3 ex. (Fedora 43) use the pip3 counterpart.
#
echo -e "\e[32m       _//             _//_//      
      _//             _//  _//     
     _//             _//    _//    
    _//             _//      _//   
   _//             _//        _//  
  _//             _//          _// 
 _//             _//            _//
                                   \e[0m"
pipx install pytap2 
echo -e "\e[32m/ /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ \e[0m"
pipx install meshtastic[cli]
echo -e "\e[32m/ /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ / /\ \e[0m"
echo "Verifying Installation..."
echo -e "\e[32mMeshtastic Version \e[0m" && meshtastic --version

echo -e "\e[32mComplete.\e[0m"
