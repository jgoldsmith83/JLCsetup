#!/usr/bin/expect -f

set PASSWORD "jobsearch"
set PASS_CHANGE "passwd"

spawn x11vnc -storepasswd ~/.vnc/$PASS_CHANGE
expect "password:" {send "jobsearch\r"}
expect "password:" {send "jobsearch\r"}
expect "Write*\?" {send "y\r"}
