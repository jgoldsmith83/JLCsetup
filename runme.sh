#!/bin/bash

#dir=$(pwd)


#function menu() {
#	clear
#	echo "Select option:"
#	echo 
#	echo "1. New Setup"
#	echo "2. Undo Setup"
#	echo "3. Exit"
#	echo
#	echo
#	read -p "> " _do
#}

#function parse_choice() {
#	if [ $_do = 1 ]; then
#		cd libs
#		su -c ./resmake.sh root
#	elif [ $_do = 2 ]; then
#		cd libs
#		su -c ./resundo.sh root
#	elif [ $_do = 3 ]; then
#		clear
#		exit
#	else
#		echo -ne "\n\nAvailable options are 1, 2, or 3...\n"
#		sleep 2
#		menu
#	fi
#}

#menu
#parse_choice

if [ ! $UID -eq 0 ]; then
	echo ""
	echo "**************************************************************"
	echo "*                                                            *"
	echo "*  This script must be run as root. Include 'sudo' like so:  *"
	echo "*                sudo ./runme.sh [port]                      *"
	echo "*                                                            *"
	echo "*             Please re-run the script as root               *"
	echo "*                                                            *"
	echo "**************************************************************"
	echo ""
        echo ""
	echo ""

	exit 1
fi

if [ -z $1 ]; then
	echo ""
	echo "************************************************************"
	echo "*                                                          *"
	echo "*  You must provide a port number as an argument like so:  *"
	echo "*               sudo ./runme.sh [port]                     *"
	echo "*                                                          *"
	echo "* Please re-run the command with a port number to be used  *"
	echo "* for vnc remote desktop.                                  *"
	echo "*                                                          *"
	echo "************************************************************"
	echo ""
        echo ""
	echo ""

	exit 2
fi

#sudo apt-get install python-tk

sudo chmod 755 libs/resmake.sh
sudo chmod 755 libs/resundo.sh

sudo chmod a+x JLCsetup.py
sudo chmod a+x rbt_conf.py
sudo chmod a+x libs/x11config.sh

sudo python -c 'import JLCsetup; JLCsetup.launch('$1')'


