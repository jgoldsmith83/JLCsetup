#!/bin/bash


function teamviewer() {

	echo "Installing Teamviewer against the developer's suggestion..."
	wget http://download.teamviewer.com/download/version_9x/teamviewer_linux.deb > /dev/null
	sudo dpkg -i teamviewer_linux.deb > /dev/null
	sudo apt-get -f install > /dev/null

}


teamviewer
