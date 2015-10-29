#!/bin/bash


if [ ! $UID -eq 0 ]; then
	echo ""
	echo "      **************************************************************"
	echo "      *                                                            *"
	echo "      *  This script must be run as root. Include 'sudo' like so:  *"
	echo "      *                sudo ./runme.sh [port]                      *"
	echo "      *                                                            *"
	echo "      *             Please re-run the script as root               *"
	echo "      *                                                            *"
	echo "      **************************************************************"
	echo ""
        echo ""
	echo ""

	exit 1
fi

#if [ -z $1 ]; then
	echo ""
	echo "      ************************************************************"
	echo "      *                                                          *"
	echo "      *  You must provide a port number as an argument like so:  *"
	echo "      *               sudo ./runme.sh [port]                     *"
	echo "      *                                                          *"
	echo "      * Please re-run the command with a port number to be used  *"
	echo "      * for vnc remote desktop.                                  *"
	echo "      *                                                          *"
	echo "      ************************************************************"
	echo ""
    echo ""
	echo ""

	#exit 3
#fi

#if ! [[ "$1" =~ ^[0-9]+$ ]]; then
	echo ""
	echo ""
	echo "      ************************************************************"
	echo "      *                                                          *"
	echo "      *          Sorry, that's not a port number...              *"
	echo "      *                                                          *"
	echo "      *  Port number must be a number. Try again like so:        *"
	echo "      *               sudo ./runme.sh 5900                       *"
	echo "      *                                                          *"
	echo "      *        Ports should correspond to the machine:           *"
	echo "      *                    5900 = Station 1                      *"
	echo "      *                    5901 = Station 2                      *"
	echo "      *                    5902 = Station 3                      *"
	echo "      *                      and so on...                        *"
	echo "      *                                                          *"
	echo "      *        Please re-run the script with a port number       *"
	echo "      *                                                          *"
	echo "      ************************************************************"
	echo ""
    echo ""
	echo ""

	#exit 2
#fi


sudo apt-get install python-tk

sudo chmod a+x remote_install.py
sudo chmod a+x JLCsetup.py
sudo chmod a+x rbt_conf.py

sudo chmod a+x resmake.sh
sudo chmod a+x resundo.sh
sudo chmod a+x x11config.sh
sudo chmod a+x vnc_only.sh
sudo chmod a+x vnc_ssh.sh
sudo chmod a+x teamviewer.sh


sudo python -c 'import JLCsetup; JLCsetup.launch()'
#sudo python -c 'import remote_install; remote_install.launch('$1')'


