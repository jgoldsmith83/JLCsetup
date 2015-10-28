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



#--Create jobsearch user accoung as Public User and set password
################################################################
echo -ne "$PASSWORD\n$PASSWORD\nPublic User\n\n\n\n\ny" | sudo adduser jobsearch --home /home/Public\ User


#--Give administrator full access to Public User Home directory
###############################################################

echo -ne "\n\nPreparing Home directory..."

echo -ne "\n\nPreparing system files and Home directories..."

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
setfacl -m u:jobsearch:0 /usr/bin/$PASS_CHANGE
setfacl -m u:jobsearch:0 /usr/bin/$DEV_MAKE
setfacl -m u:jobsearch:0 /usr/bin/$CHANGE_PERMS
setfacl -m u:jobsearch:0 /usr/bin/$REPOSITORIES
setfacl -m u:jobsearch:0 /usr/bin/$APT_GET

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

python -c "import remote_install; remote_install.launch($1)"

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

	sudo apt-get remove --purge ${i} > /dev/null

done

for i in ${scopes[@]}; do

	sudo apt-get remove --purge ${i} > /dev/null

done

for i in ${scopes[@]}; do

	sudo apt-get remove --purge ${i}

done

echo ""
echo ""


#--Transmission is a bit torrent client which comes preinstalled on most editions of Ubuntu
#--Most applications are simply being restricted - Transmission should be removed completely
#
#--          !!!DO NOT EDIT THIS FILE!!!
#--TO SPECIFY NEW TRANSMISSION COMPONENTS TO REMOVE: ADD THE COMPONENT PACKAGE NAME TO transmission.txt
#######################################################################################################

echo ""
echo ""
echo "Removing Transmission bit torrent client..."
readarray trans < libs/transmission_components.txt

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


#--Here we remove the 'userlist' from the login screen and disable the 'guest' session.
#--We will add a manual entry option - this will require the user (administrator or jobsearch)
#--to manually enter the username of the account they are logging into
#####################################################################
sudo mkdir -p /etc/lightdm/lightdm.conf.d
sudo cp /libs/50-GW-custom-config.conf /etc/lightdm/lightdm.conf.d/50-GW-custom-config.conf


#--put x11vnc.conf back the way it was before we started so we can modify it again next time
#--without having to manually change the default port number back to 5900
#########################################################################
if [ -e libs/x11vnc.conf.orig ]; then
	sed -i.orig "s/$1/9999/" libs/x11vnc.conf
	rm libs/x11vnc.conf.orig
fi

echo " "
echo " "
echo "Operation Complete."
echo " "
echo " "

exit 0