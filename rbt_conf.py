from Tkinter import *
import actions
import sys

def launch():
	msg = "All operations have completed successfully."

	root = Tk()
	root.title("Confirm Reboot")
	root.geometry("300x100+100+100")

	msg_frame = LabelFrame(root, text=msg)
	msg_frame.pack(pady=10)

	button_frame = Frame(msg_frame)
	button_frame.pack(fill=BOTH)

	now_frame = Frame(button_frame, width=100)
	now_frame.pack(side = LEFT, padx=15)

	wait_frame = Frame(button_frame, width=100)
	wait_frame.pack(side = RIGHT, padx=15)	

	now = Button(now_frame, text="Reboot Now", command=actions.rbt_now)
	now.pack(side = LEFT, padx=5, pady=10)

	wait = Button(wait_frame, text="Reboot Later", command=actions.stop)
	wait.pack(side = RIGHT, padx=5, pady=10)

	root.mainloop()
