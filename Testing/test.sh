#!/bin/bash

<<<<<<< HEAD
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

countdown 10
=======
readarray tester < test.txt

for i in ${tester[@]}; do
	echo ${i}
done

IFS=$'\n' array2=($(< test.txt))

echo ""

for i in ${tester[@]}; do
	echo ${i}
done
>>>>>>> 1e9d06b9c3dbc15c3e54dd03c61b0127c0aab5f6