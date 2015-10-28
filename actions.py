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
	call('libs/resmake.sh', shell=True)
	call(['clear'])
	remote_install.launch(port)
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




def install(v, str3, str4, port):
	if v.get() == "vnc":
		str3.set("Installing x11VNC...Please wait.")
		vnc(port)
	elif v.get() == "ssh":
		str3.set("Installing SSH...Please wait.")
		ssh()
	elif v.get() == "both":
		str3.set("Installing x11VNC and SSH...Please wait.")
		vnc_ssh(port)
	elif v.get() == "team":
		str3.set("Installing Teamviewer...Please wait.")
		str4.set("***NOT RECOMMENDED***")
		teamviewer()
	else:
		tkMessageBox.showinfo("Selection Error", "You must select an option to install")
		v.set("")
		



def vnc(port):
	#install x11vnc
	tkMessageBox.showwarning("JLC Remote Setup", "Remember this option requires port forwarding.")
	call("./libs/vnc_only.sh " + port, shell=True)
	remote_install.stop()



def ssh():
	#install ssh
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option requires port forwarding.")
	call("./libs/ssh.sh", shell=True)
	remote_install.stop()



def vnc_ssh(port):
	#install x11vnc
	#install ssh
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option requires port forwarding.")
	call("./libs/vnc_ssh.sh " + port, shell=True)
	remote_install.stop()



def teamviewer():
	#install teamviewer
	tkMessageBox.showinfo("JLC Remote Setup", "Remember this option is NOT RECOMMENDED.")
	call("./libs/teamviewer.sh", shell=True)
	remote_install.stop()




def test():
	call('./test.sh')

