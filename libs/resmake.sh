#!/bin/bash
#                                                   #
#  Author: Justin Goldsmith                         #
#  File: resmake.sh                                 #
#  Purpose:                                         #
#		- Create extended user accounts             #
#		- Restrict all unecessary applications      #
#		- Install necessary applications            #
#		- Modify existing packages as necessary     #
#                                                   #
#          !!!DO NOT EDIT THIS FILE!!!              #
#####################################################


USER_NAME="Public User"
PASSWORD="jobsearch"

#--These are set as variables because they are command line utilities
#--that will otherwise be interpreted and run when used in the script
#####################################################################
PASS_CHANGE="passwd"
DEV_MAKE="make"
CHANGE_PERMS="/bin/chmod"
REPOSITORIES="add-apt-repository"
APT_GET="apt-get"

#--Creates a countdown timer that will display a countdown while
#--instructional portions of the script are displayed.
######################################################
function countdown() {
	for ((i=$1; i>0; i--)); do
	case $1 in
	30)
	    	echo -en "Computer will restart in: " $i " ...press any key to continue...\r"
		;;
	[10,20]*)
		echo -en "Automation will resume in: " $i "  ...press any key to coninue...\r"
		;;
	esac
	sleep .3
	read -s -n 1 -t 1 key
    	if [ $? -eq 0 ]; then
		clear
        	break
    	fi
	done
	clear
}

#--Function to install and configure only x11vnc for remote desktop
###################################################################
function vnc_only() {
<<<<<<< HEAD
	
	echo "Installing ONLY x11VNC..."

	#--install and configure x11vnc server
    sudo apt-get -y install x11vnc > /dev/null
=======

	#--install and configure x11vnc server
    sudo apt-get install x11vnc
>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6
    sudo ./libs/x11config.sh

	#--Set the port number in the x11vnc.conf file and delete the original
	sed -i.orig "s/9999/$1/" setup/x11vnc.conf

	#--move necessary files to their appropriate locations
    sudo cp ~/.vnc/$PASS_CHANGE /etc/x11vnc.pass
    sudo cp libs/x11vnc.conf /etc/init/x11vnc.conf
    sudo cp libs/x11vnc.desktop /usr/shared/applications/x11vnc.desktop

	#--Start the x11vnc server to run at all times
    sudo x11vnc -forever -display :0 -shared -rfbauth /etc/x11vnc.pass &

}

#--Function to install and configure both x11vnc and ssh for remote desktop
#--and remote tunneling
####################################
function vnc_ssh() {

<<<<<<< HEAD
	echo "Installing x11VNC and ssh/sshd..."

	#--Install and configure openssh(d) and x11vnc server
    sudo apt-get -y install openssh && sudo apt-get install opensshd > /dev/null
    sudo apt-get -y install x11vnc > /dev/null
	sudo ./libs/x11config.sh > /dev/null
=======
	#--Install and configure openssh(d) and x11vnc server
    sudo apt-get install openssh && sudo apt-get install opensshd
    sudo apt-get install x11vnc
	sudo ./libs/x11config.sh
>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6
	
	#--Set the port number in the x11vnc.conf file and delete the original
	sed -i.orig "s/9999/$1/" setup/x11vnc.conf

	#--Move necessary files to their appropriate locations
    sudo cp ~/.vnc/$PASS_CHANGE /etc/x11vnc.pass
	sudo cp libs/x11vnc.conf /etc/init/x11vnc.conf
	sudo cp libs/x11vnc.desktop /usr/shared/applications/x11vnc.desktop

	#--Start the x11vnc server to run at all times
    sudo x11vnc -forever -display :0 -shared -rfbauth /etc/x11vnc.pass &

}

#--Function to install and configure Teamviewer against the developer's suggestion
##################################################################################
function teamviewer() {
<<<<<<< HEAD
	echo "Installing Teamviewer against the developer's suggestion..."
	wget http://download.teamviewer.com/download/version_9x/teamviewer_linux.deb > /dev/null
	sudo dpkg -i teamviewer_linux.deb > /dev/null
	sudo apt-get -f install > /dev/null
=======
	echo "Setting up Teamviewer for remote access..."
	cd ~/downloads
	wget http://download.teamviewer.com/download/version_9x/teamviewer_linux.deb
	sudo dpkg -i ~/Downloads/teamviewer_linux.deb
	sudo apt-get -f install
	cd /usr/bin
>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6
}



set -e

#--Create jobsearch user accoung as Public User and set password
################################################################
echo -ne "$PASSWORD\n$PASSWORD\nPublic User\n\n\n\n\ny" | sudo adduser jobsearch --home /home/Public\ User


#--Give administrator full access to Public User Home directory
###############################################################
<<<<<<< HEAD
echo -ne "\n\nPreparing Home directory..."
=======
echo -ne "\n\nPreparing system files and Home directories..."
>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6
setfacl -R -m u:administrator:rwx /home/Public\ User


sleep 5


#--Now we will begin setting permissions for the jobsearch user.
#--The following lines will disable access to unnecessary and
#--potentially dangerous applications such as music players and
#--terminal applications
#
#--                  !!!DO NOT EDIT THIS FILE!!!
#--TO ADD NEW ACL RESTRICTED APPS: ADD THE APP PATH ENTRY TO resapps.txt
#--TO REMOVE AN APP FROM THE RESTRICTED APPS LIST: REMOVE THE APP PATH ENTRY FROM resapps.txt
#############################################################################################
IFS=$'\n' resapps=($(< libs/resapps.txt))

for i in ${resapps[@]}; do
	echo "Setting full restriction for ${i}..."
	sudo setfacl -m u:jobsearch:0 ${i}
	echo ""
done
echo ""
echo "Setting full restriction for administrative utilities..."
setfacl -m u:jobsearch:0 $PASS_CHANGE
setfacl -m u:jobsearch:0 $DEV_MAKE
setfacl -m u:jobsearch:0 $CHANGE_PERMS
setfacl -m u:jobsearch:0 $REPOSITORIES
setfacl -m u:jobsearch:0 $APT_GET
echo "Granting access to Home folder..."
sudo setfacl -R -m u:jobsearch:rwx /home/Public\ User



#--SSH is needed to create a secure tunnel so we can use a vnc tunnel for remote
#--desktop. 
#--The following provides the option to install only SSH for terminal
#--administration only,
#--or x11vnc for graphical administration only, or both. There is no default
#--option butinstalling both is recommended (since most admin is done through
#--the terminal anyway).
#
#--The configuration steps for this installation can be found at
#--http://ubuntuguide.net/windows-7-remote-desktop-ubuntu-12-04
#
#--You will need to add portforwarding at the router for each machine.
#--Port: 5900 should point to station 1
#--Port: 5901 should point to station 2
#--Repeat until a port is opened for each station - ensure not to direct
#--traffic to a port already assigned to another process
#--The file /etc/x11vnc.conf will need to be modified for each machine to 
#--reflect the correct port it will listen on.
##############################################
echo " "
echo " "
echo "We need to install ssh for remote command-line access and/or"
echo "x11vnc for remote desktop access. You may choose to install"
echo "either or both depending on the machine and its intended use."
echo "Alternatively, you may opt to use Teamviewer, however this"
echo "option is not recommended as it requires additional setup"
echo "procedures which are not covered in this script or it's comments."
echo " "
countdown 10
echo " "
echo " "
<<<<<<< HEAD
#echo "What would you like to install?"
#echo " "
#echo "1. SSH Only"
#echo "2. VNC Only"
#echo "3. Both"
#echo "4. Teamviewer"
#echo "5. None"
#echo " "
#read -p "> " remote

#case $remote in
#1)
#	echo "Installing Open SSH..."
#    sudo apt-get install openssh && sudo apt-get install opensshd > /dev/null
#    ;;
#2)
#    vnc_only
#    ;;
#3)
#    vnc_ssh
#    ;;
#4)
#	teamviewer
#	;;
35)
#    echo "Skipping ssh and vnc installation. Moving on..."
#    countdown 10
#esac

python -c "import remote_install; remote_install.launch()"
python -c "import remote_install; remote_install.stop()"
=======
echo "What would you like to install?"
echo " "
echo "1. SSH Only"
echo "2. VNC Only"
echo "3. Both"
echo "4. Teamviewer"
echo "5. None"
echo " "
read -p "> " remote

case $remote in
1)
    sudo apt-get install openssh && sudo apt-get install opensshd
    ;;
2)
    vnc_only
    ;;
3)
    vnc_ssh
    ;;
4)
	teamviewer
	;;
5)
    echo "Skipping ssh and vnc installation. Moving on..."
    countdown 10
esac

>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6

#--Later editions of Ubuntu include scopes and lenses for displaying search results
#--for shopping sites and music stores in the dash. We need to remove them so as 
#--not to entice users onto sites like Amazon or itunes.
#
#--            !!!DO NOT EDIT THIS FILE!!!
#--TO SPECIFY NEW LENSES TO REMOVE: ADD THE LENSE PACKAGE NAME TO lenses.txt
#--TO SPECIFY NEW SCOPES TO REMOVE: ADD THE SCOPE PACKAGE NAME TO scopes.txt
############################################################################
readarray lenses < libs/lenses.txt
readarray scopes < libs/scopes.txt

echo ""
echo ""
echo "Removing scopes and lenses for shopping, social networks,"
echo "and other frivolous additions."
echo ""
echo ""

for i in ${lenses[@]}; do
<<<<<<< HEAD
	sudo apt-get remove --purge ${i} > /dev/null
done

for i in ${scopes[@]}; do
	sudo apt-get remove --purge ${i} > /dev/null
=======
	sudo apt-get remove --purge ${i}
done

for i in ${scopes[@]}; do
	sudo apt-get remove --purge ${i}
>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6
done

echo ""
echo ""


#--Transmission is a bit torrent client which comes preinstalled on most editions of Ubuntu
#--Most applications are simply being restricted - Transmission should be removed completely
#
#--          !!!DO NOT EDIT THIS FILE!!!
#--TO SPECIFY NEW TRANSMISSION COMPONENTS TO REMOVE: ADD THE COMPONENT PACKAGE NAME TO transmission.txt
#######################################################################################################
<<<<<<< HEAD
echo ""
echo ""
echo "Removing Transmission bit torrent client..."
readarray trans < transmission_components.txt

for i in ${trans[@]}; do
	sudo apt-get remove --purge ${i} > /dev/null
done


#--Now we will install Google Chrome and add it to the launcher
#--Once Chrome is installed and added to the laucnher, we will remove Firefox
#############################################################################
echo ""
echo "Downloading and installing Google signing key for Linux..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo ""
echo "Adding Google repositories to sources.list.d/google.list"
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
echo ""
echo "Updating package repository..."
sudo apt-get update > /dev/null
echo ""
echo "Installing Google Chrome Stable..."
sudo apt-get install google-chrome-stable > /dev/null


=======
readarray trans < transmission_components.txt

for i in ${trans[@]}; do
	sudo apt-get remove --purge ${i}
done


>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6
#--put x11vnc.conf back the way it was before we started so we can modify it again next time
#--without having to manually change the default port number back to 5900
#########################################################################
if [ -e setup/x11vnc.conf.orig ]; then
	sed -i.orig "s/$1/9999/" setup/x11vnc.conf
	rm setup/x11vnc.conf.orig
fi

echo " "
echo " "
echo "Operation Complete."
echo " "
echo " "

exit 0
