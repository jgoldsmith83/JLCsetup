import sys
from subprocess import call
import rbt_conf
import JLCsetup

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

def rbt_ltr():
	rbt_conf.launch()
	sys.exit()

def stop():
	JLCsetup.quit()
	sys.exit()

def test():
	call('./test.sh')
