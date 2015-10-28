#!/bin/bash


function vnc_ssh() {


	echo "Installing x11VNC and ssh/sshd..."

	#--Install and configure openssh(d) and x11vnc server
    sudo apt-get -y install openssh && sudo apt-get install opensshd > /dev/null
    sudo apt-get -y install x11vnc > /dev/null
	sudo ./libs/x11config.sh > /dev/null

	#--Set the port number in the x11vnc.conf file and delete the original
	sed -i.orig "s/9999/$1/" setup/x11vnc.conf

	#--Move necessary files to their appropriate locations
    sudo cp ~/.vnc/$PASS_CHANGE /etc/x11vnc.pass
	sudo cp libs/x11vnc.conf /etc/init/x11vnc.conf
	sudo cp libs/x11vnc.desktop /usr/shared/applications/x11vnc.desktop

	#--Start the x11vnc server to run at all times
    sudo x11vnc -forever -display :0 -shared -rfbauth /etc/x11vnc.pass &

}


vnc_ssh
