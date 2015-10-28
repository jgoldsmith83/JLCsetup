#!/bin/bash


function vnc_only() {

	
	echo "Installing ONLY x11VNC..."

	#--install and configure x11vnc server
    sudo apt-get -y install x11vnc > /dev/null

    sudo ./libs/x11config.sh

	#--Set the port number in the x11vnc.conf file and delete the original
	sed -i.orig "s/9999/$1/" x11vnc.conf

	#--move necessary files to their appropriate locations
    sudo cp ~/.vnc/$PASS_CHANGE /etc/x11vnc.pass
    sudo cp x11vnc.conf /etc/init/x11vnc.conf
    sudo cp x11vnc.desktop /usr/shared/applications/x11vnc.desktop

	#--Start the x11vnc server to run at all times
    sudo /usr/binx11vnc -bg -reopen -forever -display :0 -o /var/log/x11vnc.log -auth /var/run/lightdm/root/:0 -rfbauth /etc/x11vnc.pass &

}


vnc_only
