#!/usr/bin/python3

import actions
from Tkinter import *
import sys
from PIL import Image

def launch(port):

	root = Tk()
	root.title("Palmetto Goodwill - JLC Setup")
	root.geometry("500x300+100+100")
	icon = PhotoImage(file = 'images/GW_icon.ppm')
	#root.wm_iconbitmap('@GW_icon.ppm')
	root.tk.call('wm', 'iconphoto', root._w, icon)

	logo = PhotoImage(file="images/GW_logo.ppm")
	expln = StringVar()
	expln_supp = StringVar()

	main = Frame(root, width=400, height=200)
	main.pack(pady=5)

	heading = Label(main, image=logo)
	heading.image = logo
	heading.pack() 

	button_frame = Frame(main)
	button_frame.pack(pady=10, anchor=W)
	
	setup = Button(button_frame,text="New Setup",command=lambda: actions.new_setup(port))
	setup.bind("Enter", actions.setupExpln(expln))
	setup.bind("Leave", expln.set(""))
	setup.pack(anchor=W, padx=40, side="left")

	#undo_frame = Frame(main)
	#undo_frame.pack(anchor=W)
	undo = Button(button_frame,text="Undo Setup",command=actions.undo_setup)
	undo.pack(anchor=W, side="left")

	#exit_frame = Frame(main)
	#exit_frame.pack(pady=10, anchor=W)
	exit = Button(button_frame,text="Quit Setup",command=quit)
	exit.pack(anchor=W, padx=40, side="left")

	info = Label(main, textvariable=expln)
	info.pack()
	info_supp = Label(main, textvariable=expln_supp)
	info_supp.pack()

	root.mainloop()


def quit():
	exit()


