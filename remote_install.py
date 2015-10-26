import actions
from os import system
from subprocess import call
import sys
from Tkinter import *
import tkMessageBox

value = ""


def launch():
	root = Tk()
	root.title("JLC Remote Setup")
	root.geometry('450x290+200+240')
	
	str1_font = ('times', 12, 'bold')
	
	str1 = StringVar()
	str1.set("Choose your remote configuration")
	
	str2 = StringVar()
	str2.set("Select to install x11VNC, SSH, Both, or Teamviewer(not recommended)")

	str3 = StringVar()
	str4 = StringVar()
	
	
	
	title = Frame(root, width=300, height=250)
	title.pack(pady=20)
	
	instruct_title = Label(title, textvariable=str1)
	instruct_title.config(font=str1_font)
	instruct_title.pack(anchor=W)
	
	instruct = Label(title, textvariable=str2)
	instruct.pack(pady=10)
	
	v = StringVar()
	
	Radiobutton(title, text="x11VNC", variable=v, value="vnc").pack(anchor=W, padx=20)
	Radiobutton(title, text="SSH", variable=v, value="ssh").pack(anchor=W, padx=20)
	Radiobutton(title, text="VNC & SSH", variable=v, value="both").pack(anchor=W, padx=20)
	Radiobutton(title, text="Teamviewer", variable=v, value="team").pack(anchor=W, padx=20)
	
	install = Button(title, text="INSTALL NOW", command=lambda: actions.install(v, str3, str4))
	install.pack(pady=10)

	confirm = Label(title, textvariable=str3)
	confirm.pack(pady=5)
	
	warning = Label(title, textvariable=str4)
	warning.pack()
	
	root.mainloop()



def testecho(v):
	call(['echo ' + v.get()], shell=True)


def stop():
	#exit window
	sys.exit()

