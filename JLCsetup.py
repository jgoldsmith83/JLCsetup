#!/usr/bin/python3

import actions
from Tkinter import *
import tkMessageBox
import re
import sys
from PIL import Image
from subprocess import call


def launch():

	root = Tk()
	root.title("Palmetto Goodwill - JLC Setup")
	root.geometry("500x320+100+100")
	root.resizable(0,0)
	icon = PhotoImage(file = 'images/GW_icon.ppm')
	#root.wm_iconbitmap('@GW_icon.ppm')
	root.tk.call('wm', 'iconphoto', root._w, icon)


	def set_setup_expln(event):
		expln.set("       Setup JLC Station")
		info.pack_forget()
		info.config(anchor=W)
		info.pack(side="left")
		objective.set("-Setup Public User account and set password\n" +
					  "-Restrict all unnecessary applications\n" +
					  "-Install administrative applications\n" +
					  "-Install and setup remote desktop access")

	def unset_setup_expln(event):
		expln.set("")
		objective.set("Select an option to begin.")

	def set_undo_expln(event):
		expln.set("Uninstall Previous Changes")
		info.pack_forget()
		info.config(anchor=CENTER)
		info.pack()
		objective.set("-Remove Public User account\n" + 
					  "-Delete all Public User files\n" +
					  "-Remove application restrictions\n" +
					  "-Remove remote desktop software")

	def unset_undo_expln(evnt):
		expln.set("")
		objective.set("Select an option to begin.")

	def set_exit_expln(event):
		expln.set("Quit Setup                 ")
		info.pack_forget()
		info.config(anchor=E)
		info.pack(side='right')
		objective.set("-Take no action\n" +
					  "-Exit Setup")

	def unset_exit_expln(event):
		expln.set("")
		objective.set("Select an option to begin.")

	def get_port():
		def send_port():
			port = entry.get()
			port = str(port)

			if len(port) == 0:
				tkMessageBox.showerror("Error","We need a port number to make this work...")
				entry.focus_set()
			elif re.match('^[0-9]+$',port) is None:
				tkMessageBox.showerror("Error","Port number should be a number.")
				root.focus_set()
				entry.focus_set()
			else:
				actions.new_setup(port)
		
		info.pack_forget()
		expln.set("Enter port number:")
		port_info = Label(info_frame,text="Enter port number:")
		port_info.config(anchor=CENTER)
		port_info.pack()

		obj_info.pack_forget()
		entry = Entry(obj_frame)
		entry.focus_set()
		entry.bind('<Return>', send_port)
		entry.pack()

		start = Button(obj_frame,text="Start",command=send_port)
		start.pack(pady=5)

		setup.unbind('<Enter>')
		undo.unbind('<Enter>')
		exit.unbind('<Enter>')

		


	expln_font = ('times', 12, 'bold')


	main = Frame(root, width=400, height=200)
	main.pack(pady=5)

	logo = PhotoImage(file="images/GW_logo.ppm")

	expln = StringVar()
	objective = StringVar()


	expln.set("")
	objective.set("Select an option to begin.")


	heading = Label(main, image=logo)
	heading.image = logo
	heading.pack() 

	button_frame = Frame(main)
	button_frame.pack(pady=10, anchor=W)

	setup_frame = Frame(button_frame)
	setup_frame.pack(anchor=W, padx=40, side="left")

	
	setup = Button(setup_frame,text="New Setup",command=get_port)
	setup.bind('<Enter>', set_setup_expln)
	setup.bind("<Leave>", unset_setup_expln)
	setup.pack()


	undo_frame = Frame(button_frame)
	undo_frame.pack(anchor=W, side="left")

	undo = Button(undo_frame,text="Undo Setup",command=actions.undo_setup)
	undo.bind('<Enter>', set_undo_expln)
	undo.bind('<Leave>', unset_undo_expln)
	undo.pack()

	exit_frame = Frame(button_frame)
	exit_frame.pack(anchor=W, padx=40, side="left")

	exit = Button(exit_frame,text="Quit Setup",command=quit)
	exit.bind('<Enter>', set_exit_expln)
	exit.bind('<Leave>', unset_exit_expln)
	exit.pack()

	info_frame = Frame(main)
	info_frame.pack(fill=X, pady=5)
	obj_frame = Frame(main)
	obj_frame.pack(pady=5)

	info = Label(info_frame, textvariable=expln)
	info.config(font=expln_font)
	info.pack(side='left')

	obj_info = Label(obj_frame, textvariable=objective)
	obj_info.config(justify='left')
	obj_info.pack(anchor=CENTER)


	root.mainloop()




def quit():
	sys.exit(0)


