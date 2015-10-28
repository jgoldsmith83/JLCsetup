#!/bin/bash


function vnc_only() {

	
	echo "Installing ONLY x11VNC..."

	#--install and configure x11vnc server
    sudo apt-get -y install x11vnc > /dev/null

    sudo ./libs/x11config.sh

	#--Set the port number in the x11vnc.conf file and delete the original
	sed -i.orig "s/9999/$1/" libs/x11vnc.conf

	#--move necessary files to their appropriate locations
    sudo cp ~/.vnc/$PASS_CHANGE /etc/x11vnc.pass
    sudo cp libs/x11vnc.conf /etc/init/x11vnc.conf
    sudo cp libs/x11vnc.desktop /usr/shared/applications/x11vnc.desktop

}


vnc_only
