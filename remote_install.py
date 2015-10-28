import actions
from os import system
from subprocess import call
import sys
from Tkinter import *
import tkMessageBox



def launch(port):
	str(port)
	#Create the root window called root
	root = Tk()
	#Set the title bar text
	root.title("JLC Remote Setup")
	#Define the window size and location on screen
	root.geometry('450x290+200+240')
	
	#Custom font for the heading
	str1_font = ('times', 12, 'bold')
	
	#Declare and define the text to be used for the heading
	str1 = StringVar()
	str1.set("Choose your remote configuration")

	#Declare and define the text to be used for instruction
	str2 = StringVar()
	str2.set("Select to install x11VNC, SSH, Both, or Teamviewer(not recommended)")

	#Empty strings used for indicator text (text set depending on user input)
	str3 = StringVar()
	str4 = StringVar()
	
	
	#Create the main frame to hold all other widgets
	main = Frame(root, width=300, height=250)
	main.pack(pady=20)
	
	#Label widget used to display the heading heading
	instruct_title = Label(main, textvariable=str1)
	instruct_title.config(font=str1_font)
	instruct_title.pack(anchor=W)
	
	#Label widget used to display the instruction text
	instruct = Label(main, textvariable=str2)
	instruct.pack(pady=10)
	
	#String that corresponds to the active rabiobutton's value attribute
	v = StringVar()
	
	#Radio buttons used for accepting user choice - the coin toss
	Radiobutton(main, text="x11VNC", variable=v, value="vnc").pack(anchor=W, padx=20)
	Radiobutton(main, text="SSH", variable=v, value="ssh").pack(anchor=W, padx=20)
	Radiobutton(main, text="VNC & SSH", variable=v, value="both").pack(anchor=W, padx=20)
	Radiobutton(main, text="Teamviewer", variable=v, value="team").pack(anchor=W, padx=20)
	
	#Button used to run install() based on user input - the kick off
	install = Button(main, text="INSTALL NOW", command=lambda: actions.install(v, str3, str4, port))
	install.pack(pady=10)

	#Label used to display str3 - value set in actions.install()
	confirm = Label(main, textvariable=str3)
	confirm.pack(pady=5)
	
	#Label used to display str4 - value set in actions.install()
	warning = Label(main, textvariable=str4)
	warning.pack()
	
	#Start the window process and launch the window
	root.mainloop()


#Deprecated - keeping just in case
def stop():
	#exit window
	sys.exit()

