import sys
from subprocess import call
import rbt_conf
import JLCsetup
import remote_install
from Tkinter import *
import tkMessageBox
import time

def new_setup(port):
	call(['clear'])
	#call(['sudo su'])
	call('libs/resmake.sh'+' '+port, shell=True)
	call(['clear'])
	rbt_conf.launch()
	


def undo_setup():
	call(['clear'])
	call("libs/resundo.sh", shell=True)
	rbt_conf.launch()




def rbt_now():
	call("sudo reboot now", shell=True)




def rbt_now():
	call("sudo reboot now", shell=True)



def rbt_ltr():
	rbt_conf.launch()
	sys.exit()




def stop():
	JLCsetup.quit()
	sys.exit()




def install(v, str3, str4):
	if v.get() == "vnc":
		str3.set("Installing x11VNC...Please wait.")
		vnc(v)
	elif v.get() == "ssh":
		str3.set("Installing SSH...Please wait.")
		ssh(v)
	elif v.get() == "both":
		str3.set("Installing x11VNC and SSH...Please wait.")
		vnc_ssh()
	elif v.get() == "team":
		str3.set("Installing Teamviewer...Please wait.")
		str4.set("***NOT RECOMMENDED***")
		teamviewer()
	else:
		tkMessageBox.showinfo("Selection Error", "You must select an option to install")
		v.set("")
		



def vnc(v):
	#install x11vnc
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option requires port forwarding.")
	call("Testing/test.sh", shell=True)
	remote_install.stop()



def ssh(v):
	#install ssh
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option requires port forwarding.")
	call("Testing/test.sh", shell=True)
	remote_install.stop()



def vnc_ssh():
	#install x11vnc
	#install ssh
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option requires port forwarding.")
	call("Testing/test.sh", shell=True)
	remote_install.stop()



def teamviewer():
	#install teamviewer
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option is NOT RECOMMENDED.")
	call("Testing/test.sh", shell=True)
	remote_install.stop()




def test():
	call('./test.sh')