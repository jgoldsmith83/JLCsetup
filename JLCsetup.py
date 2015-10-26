import actions
from Tkinter import *
import sys

def launch(port):
	port = str(port)

	root = Tk()
	root.title("Palmetto Goodwill")
	root.geometry("200x200+100+100")
	icon = PhotoImage(file = 'images/GW_icon.ppm')
	#root.wm_iconbitmap('@GW_icon.ppm')
	root.tk.call('wm', 'iconphoto', root._w, icon)

	title = LabelFrame(root,text="JLC Ubuntu Setup")
	title.pack(pady=20)

	setup_frame = Frame(title)
	setup_frame.pack(pady=10)
	setup = Button(setup_frame,text="New Setup",command=lambda: actions.new_setup(port))
	setup.pack()

	undo_frame = Frame(title)
	undo_frame.pack()
	undo = Button(undo_frame,text="Undo Setup",command=actions.undo_setup)
	undo.pack()

	exit_frame = Frame(title)
	exit_frame.pack(pady=10)
	exit = Button(exit_frame,text="Quit Setup",command=quit)
	exit.pack()

	root.mainloop()


def quit():
	exit()
